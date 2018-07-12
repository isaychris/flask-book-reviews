import os

from flask import Flask, session, render_template, request, redirect, url_for, flash
from flask_session import Session
from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker
import requests

app = Flask(__name__)

# Check for environment variable
if not os.getenv("DATABASE_URL"):
    raise RuntimeError("DATABASE_URL is not set")

# Configure session to use filesystem
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

# Set up database
engine = create_engine(os.getenv("DATABASE_URL"))
db = scoped_session(sessionmaker(bind=engine))

@app.route("/")
def index():
    return "Project 1"

@app.route("/register", methods=["GET", "POST"])
def register():
    message = None

    if request.method == "POST":
        usern = request.form.get("username")
        passw = request.form.get("password")
        result = db.execute("INSERT INTO accounts (username, password) VALUES (:u, :p)", {"u": usern, "p": passw})
        db.commit()

        if result.rowcount > 0:
            message = "Account created!"
        else:
            message = "Unable to create account."

    return render_template("registration.html", message=message)

@app.route("/logout")
def logout():
    session.pop('logged_in', None)
    flash('You were logged out')
    return redirect(url_for('login'))

@app.route("/login", methods=["GET", "POST"])
def login():
    message = None

    if request.method == "POST":
        usern = request.form.get("username")
        passw = request.form.get("password")
        print(usern, passw)
        result = db.execute("SELECT * FROM accounts WHERE username = :u AND password = :p", {"u": usern, "p": passw})

        if result.rowcount > 0:
            return redirect(url_for('dashboard'))
        else:
            message = "Username or password is incorrect."

    return render_template("login.html", message=message)

@app.route("/dashboard")
def dashboard():
    return render_template("dashboard.html")

@app.route("/dashboard/search", methods=["POST"])
def search():
    message = None
    thestring = request.form.get("test5")
    results = db.execute("SELECT * FROM books WHERE title = :q OR isbn = :q OR author = :q", {"q": thestring}).fetchall()

    return render_template("search.html", results=results)