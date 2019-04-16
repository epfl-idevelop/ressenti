# Almost straight out of https://docs.docker.com/compose/gettingstarted/

FROM python:3.7-alpine
ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt
CMD ["python", "sync_ressenti.py"]
