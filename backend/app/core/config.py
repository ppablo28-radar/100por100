from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    DATABASE_URL: str = "postgresql+asyncpg://localhost/100x100"
    SYNC_DATABASE_URL: str = "postgresql+psycopg2://localhost/100x100"

    class Config:
        env_file = ".env"
        extra = "ignore"


settings = Settings()
