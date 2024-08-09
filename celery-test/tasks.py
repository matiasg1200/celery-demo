from celery import Celery
from time import sleep

app = Celery('tasks', broker='redis://localhost:6379', backend='db+postgresql://test:adminpwd@localhost:5432/test')

@app.task
def reverse(text):
    print('processing.. wait a few secs')
    sleep(5)
    print('your reversed string is: ')
    return text[::-1]
