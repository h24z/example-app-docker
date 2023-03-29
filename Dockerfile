# build the image based on python:3.8-slim-buster image
FROM python:3.11.2-slim-bullseye

# metadata in the form of key=value about the maintainer of the image
LABEL Maintainer_Name="agusty" Maintainer_Email="agusty91@gmail.com" 

# Upgrade pip first to avoid future incompatibilies
RUN pip install --upgrade pip >/dev/null 2>&1

# the work directory inside the container
RUN useradd worker
USER worker
WORKDIR /home/worker/app

# set enviournment variables 
ENV FLASK_APP app.py
ENV FLASK_ENV development

# copy the requirements file inside the container
COPY --chown=worker:worker requirements.txt /home/worker/requirements.txt

# install the requirements using pip3
RUN pip3 install --user -r /home/worker/requirements.txt

ENV PATH="/home/worker/bin:${PATH}"

# copy the project artefects into the container under the root directory
COPY --chown=worker:worker . /home/worker/app/

# the command to run once we run the container 
CMD python3 /home/worker/app/app.py