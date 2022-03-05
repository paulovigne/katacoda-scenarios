import os
from flask import Flask
app = Flask(__name__)

@app.route("/")
def main():
    return "Bem Vindo ao Docker Build!"

@app.route('/comovai')
def hello():
    return 'Muito Bem!'

if __name__ == "__main__":
    app.run()
