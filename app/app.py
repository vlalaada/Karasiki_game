import os
import requests
from fastapi import FastAPI
from pydantic import BaseModel
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
app = FastAPI()

app.add_middleware(CORSMiddleware, allow_origins=["*"], allow_methods=["*"], allow_headers=["*"])

YANDEX_API_KEY = os.getenv("YANDEX_API_KEY")
YANDEX_FOLDER_ID = "b1gdhgqtmmv079foch9s"


class UserRequest(BaseModel):
    message: str


def get_game_context(user_query: str) -> str:
    if not os.path.exists("game_rules.txt"):
        return ""

    with open("game_rules.txt", "r", encoding="utf-8") as f:
        text = f.read()

    paragraphs = text.split("\n\n")
    relevant_chunks = []

    for paragraph in paragraphs:
        if any(word.lower() in paragraph.lower() for word in user_query.split()):
            relevant_chunks.append(paragraph)

    return "\n".join(relevant_chunks[:3])

@app.post("/ask-bot")
async def ask_bot(request:UserRequest):
    user_text = request.message

    game_context = get_game_context(user_text)

    system_prompt = (
        "Ты добрый и веселый помощник в детской игре. Отвечай просто, используй эмодзи.\n"
        "Для ответа используй ТОЛЬКО эти правила игры:\n"
        f"=== НАЧАЛО ПРАВИЛ ===\n{game_context}\n=== КОНЕЦ ПРАВИЛ ==="
    )

    url = "https://llm.api.cloud.yandex.net/foundationModels/v1/completion"

    headers = {
        "Authorization": f"Api-Key {YANDEX_API_KEY}",
        "x-folder-id": YANDEX_FOLDER_ID
    }

    data = {
        "modelUri": f"gpt://{YANDEX_FOLDER_ID}/yandexgpt/latest",
        "completionOptions": {
            "stream": False,
            "temperature": 0.3,
            "maxTokens": "1000"
        },
        "messages": [
            {"role": "system", "text": system_prompt},
            {"role": "user", "text": user_text}
        ]
    }

    response = requests.post(url, headers=headers, json=data)

    if response.status_code == 200:
        result = response.json()
        ai_reply = result["result"]["alternatives"][0]["message"]["text"]
    else:
        ai_reply = f"Ошибка Яндекса: {response.text}"

    return {"reply": ai_reply}