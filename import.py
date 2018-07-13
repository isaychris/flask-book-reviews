import sys
import csv
import os

from sqlalchemy import create_engine
from sqlalchemy.orm import scoped_session, sessionmaker

engine = create_engine(os.getenv("DATABASE_URL"))
db = scoped_session(sessionmaker(bind=engine))

def main():
    f = open("books.csv")
    reader = csv.reader(f)
    header = next(reader)

    print("Running script ... ")
    for isbn, title, author, year in reader:
        db.execute("INSERT INTO books(isbn, title, author, year) VALUES(:i, :t, :a, :y)", {"i": isbn, "t": title, "a": author, "y": year})

    db.commit()
    
    print("Completed ... ")


if __name__ == "__main__":
    main()