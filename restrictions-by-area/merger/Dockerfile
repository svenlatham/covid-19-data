FROM python:3.9.1-slim-buster
RUN pip install pyyaml
COPY parser.py /
COPY local_restrictions.yml /
ENTRYPOINT ["python","/parser.py"]