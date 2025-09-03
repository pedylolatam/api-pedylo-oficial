# 🚀 Guía de Instalación - Pedylo API V1 (con EasyPanel)

Este documento describe los pasos **para principiantes** para instalar y ejecutar Pedylo API V1 en un VPS con **EasyPanel**.

---

## 1. 📂 Subir el proyecto
1. Ingresa a tu **EasyPanel** (ejemplo: `https://tuservidor:3000`).
2. Crea un **nuevo proyecto** → selecciona **Docker Compose**.
3. En la sección de **código fuente** elige **Subir archivos** o conecta tu repositorio (GitHub/GitLab).  
   - Si usas el `.zip` generado, súbelo y descomprímelo dentro del proyecto.

---

## 2. ⚙️ Configurar Variables de Entorno
1. Duplica el archivo `.env.example` y renómbralo como `.env`.
2. Edita el archivo `.env` y completa con tus valores reales:
   ```env
   DATABASE_URL="mysql://usuario:contraseña@db:3306/pedylo"
   META_APP_ID="tu_app_id_meta"
   META_APP_SECRET="tu_app_secret_meta"
   META_VERIFY_TOKEN="token_webhook_verificacion"
   META_WEBHOOK_URL="https://tudominio.com/webhook"
   API_KEY="clave_api_segura"
   ```

⚠️ Importante: Si la contraseña de tu base de datos fue generada automáticamente por EasyPanel, cópiala desde la interfaz de EasyPanel y actualízala aquí.

---

## 3. 🗄️ Inicializar Base de Datos
1. Abre la terminal del contenedor (`Exec` → `bash`).
2. Ejecuta las migraciones con Prisma:
   ```bash
   npx prisma migrate deploy
   ```
3. (Opcional) Genera datos de prueba:
   ```bash
   ts-node scripts/seed.ts
   ```

---

## 4. ▶️ Iniciar la API
1. Desde EasyPanel, haz clic en **Deploy** del proyecto.
2. El contenedor levantará automáticamente con:
   - `src/server.ts` como punto de entrada.
   - API expuesta en el puerto configurado (por defecto 3000).

---

## 5. ✅ Verificar instalación
1. Accede a tu dominio o IP:
   ```bash
   curl https://tudominio.com/health
   ```
   Deberías recibir: `{ "status": "ok" }`
2. Comprueba los endpoints principales:
   - `POST /auth/login`
   - `POST /messages/send`
   - `POST /meta/signup` (flujo coexistencia Meta)
   - `POST /webhook` (recepción eventos Meta)

---

## 6. 🧪 Tests
Ejecuta pruebas unitarias dentro del contenedor:
```bash
npm run test
```

---

## 7. 📘 Documentación Adicional
- [docs/README.md](./docs/README.md) → Introducción general  
- [docs/META_COEXISTENCE.md](./docs/META_COEXISTENCE.md) → Guía completa de coexistencia Meta  
- [docs/INSTALLATION.md](./docs/INSTALLATION.md) → Este archivo  
- [docs/POSTMAN_COLLECTION.json](./docs/POSTMAN_COLLECTION.json) → Colección Postman lista para pruebas  

---

## 8. 🔐 Seguridad y Producción
- Usa siempre **HTTPS** (Let’s Encrypt en EasyPanel).  
- Cambia contraseñas y tokens por valores fuertes.  
- Configura backups automáticos de tu base de datos.  

---

¡Listo! 🚀 Tu **Pedylo API V1** ya debería estar funcionando en EasyPanel.
