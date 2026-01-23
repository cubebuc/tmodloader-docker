FROM mcr.microsoft.com/dotnet/sdk:8.0

ARG TML_VERSION

WORKDIR /app

RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/tModLoader/tModLoader/releases/download/${TML_VERSION}/tModLoader.zip \
    && unzip tModLoader.zip \
    && rm tModLoader.zip \
    && chmod +x *.sh

RUN chown -R 1001:1001 /app

EXPOSE 7777

CMD ["./start-tModLoaderServer.sh", "-savedirectory", "/app/data"]
