# Referencia de API

## Clase DartTelegramBot

### Métodos
- `command(String name, HandlerFunc handler)`  
  Registra un nuevo comando

- `use(Middleware middleware)`  
  Añade middleware al pipeline

- `start({int pollingInterval})`  
  Inicia el bot en modo polling 