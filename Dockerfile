FROM python:slim-bullseye

LABEL Maintainer_Name="agusty" Maintainer_Email="agusty91@gmail.com" 

RUN useradd worker
USER worker
WORKDIR /home/worker/app

COPY --chown=worker:worker . /home/worker/app/

ENV PATH="/home/worker/.local/bin:${PATH}"
ENV FLASK_APP /home/worker/app/app.py
ENV FLASK_ENV development

RUN pip3 install --upgrade pip >/dev/null 2>&1
RUN pip3 install --user -r /home/worker/app/requirements.txt
RUN rm -f /home/worker/app/requirements.txt

CMD python3 /home/worker/app/app.py