# Almost straight out of https://docs.docker.com/compose/gettingstarted/

FROM python:3.7-alpine
WORKDIR /code
ADD requirements.txt .
RUN pip install -r requirements.txt
ADD sync_ressenti.py .
CMD ["python", "/code/sync_ressenti.py"]
