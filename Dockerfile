FROM python:3.11-slim AS build

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /app
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.11-slim

RUN useradd --create-home --shell /usr/sbin/nologin appuser

WORKDIR /app
COPY --from=build /opt/venv /opt/venv
COPY app/app.py .

ENV PATH="/opt/venv/bin:$PATH"

USER appuser
EXPOSE 5000
CMD ["python", "app.py"]
