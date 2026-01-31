from fastapi import FastAPI

app = FastAPI(
    title="Walmart Sales Monitoring System",
    description="Sistema de monitoreo y análisis de ventas (proyecto académico)",
    version="0.1.0"
)

@app.get("/")
def root():
    return {"status": "Backend running"}
