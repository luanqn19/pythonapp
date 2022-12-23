FROM python:3.8
WORKDIR /src
COPY . /src
RUN pip install flask
RUN && \
  pip install flask_restful && \
  pre-commit install --install-hooks -t pre-commit
EXPOSE 3333
ENTRYPOINT ["python"]
CMD ["./src/helloworld.py"]
