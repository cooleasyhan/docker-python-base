FROM python:3.6-alpine

ENV PYTHONUNBUFFERED 1

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN pip config set global.index-url http://pypi.douban.com/simple
RUN pip config set install.trusted-host pypi.douban.com

RUN apk update \
  # psycopg2 dependencies
  && apk add --virtual build-deps gcc python3-dev musl-dev \
  # Pillow dependencies
  && apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev \
  # CFFI dependencies
  && apk add libffi-dev py-cffi \
  # Translations dependencies
  && apk add gettext

RUN apk add supervisor
RUN pip install gunicorn
COPY ./docker-base.txt ./docker-base.txt
RUN pip install -r docker-base.txt
CMD ["python"]
