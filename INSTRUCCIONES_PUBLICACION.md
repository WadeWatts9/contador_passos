# Instrucciones para Publicar en Google Play Store

## 📱 Archivo .AAB Generado

El archivo Android App Bundle (.aab) ha sido generado exitosamente:

- **Archivo**: `contador_passos-release.aab`
- **Tamaño**: 37MB
- **Ubicación**: `/Users/alancanto/Desktop/contador_passos/contador_passos-release.aab`
- **Fecha de generación**: 14 de Julio de 2025

## 🚀 Pasos para Publicar en Google Play Store

### 1. Acceder a Google Play Console

1. Ve a [Google Play Console](https://play.google.com/console)
2. Inicia sesión con tu cuenta de desarrollador de Google
3. Si no tienes una cuenta de desarrollador, regístrate pagando la tarifa de $25 USD

### 2. Crear Nueva Aplicación

1. En la consola, haz clic en "Crear aplicación"
2. Selecciona el idioma predeterminado (Español)
3. Ingresa el nombre de la aplicación: **"Contador de Passos"**
4. Especifica que es una aplicación gratuita
5. Acepta los términos y condiciones

### 3. Configurar Información de la Aplicación

#### Información Básica:
- **Nombre de la aplicación**: Contador de Passos
- **Descripción corta**: Contador de pasos con Health Connect
- **Descripción completa**: Usar la descripción del archivo `DOCUMENTACION_PLAY_STORE.md`

#### Categoría:
- **Categoría principal**: Salud y fitness
- **Categoría secundaria**: Productividad

#### Etiquetas:
- contador de pasos
- health connect
- fitness
- actividad física
- smartwatch
- wear os

### 4. Subir el Archivo .AAB

1. En la sección "Producción", haz clic en "Crear nueva versión"
2. Sube el archivo `contador_passos-release.aab`
3. Agrega notas de la versión:
   ```
   Versión inicial de Contador de Passos
   - Integración con Health Connect
   - Soporte para smartphones y smartwatches
   - Interfaz moderna y responsive
   - Monitoreo de pasos en tiempo real
   ```

### 5. Configurar Contenido de la Aplicación

#### Capturas de Pantalla:
- Subir las capturas de pantalla de la carpeta `android/screenshots/`
- Incluir capturas para smartphones y smartwatches
- Mínimo 2 capturas, máximo 8 por dispositivo

#### Imagen de la Aplicación:
- Crear un ícono de 512x512 píxeles
- Formato PNG con fondo transparente

#### Imagen destacada:
- Crear una imagen de 1024x500 píxeles
- Mostrar la funcionalidad principal de la app

### 6. Configurar Clasificación de Contenido

1. Completar el cuestionario de clasificación de contenido
2. La aplicación se clasificará como **"Para todos"** ya que:
   - No contiene violencia
   - No contiene contenido sexual
   - No contiene lenguaje inapropiado
   - No contiene sustancias controladas

### 7. Configurar Precios y Distribución

#### Precio:
- **Gratis** (sin compras dentro de la aplicación)

#### Países:
- Seleccionar todos los países donde quieres distribuir
- Recomendado: comenzar con países de habla hispana

### 8. Configurar Permisos

La aplicación requiere los siguientes permisos:
- `android.permission.ACTIVITY_RECOGNITION` - Para contar pasos
- `android.permission.HEALTH_CONNECT_READ_STEPS` - Para leer datos de Health Connect
- `android.permission.HEALTH_CONNECT_WRITE_STEPS` - Para escribir datos de Health Connect

### 9. Política de Privacidad

1. Crear una política de privacidad que incluya:
   - Qué datos se recopilan (pasos, datos de Health Connect)
   - Cómo se usan los datos
   - Con quién se comparten los datos (solo con Health Connect)
   - Cómo los usuarios pueden solicitar la eliminación de datos

2. Subir la URL de la política de privacidad en la consola

### 10. Revisar y Publicar

1. Revisar toda la información ingresada
2. Verificar que el archivo .aab se subió correctamente
3. Hacer clic en "Revisar versión"
4. Una vez aprobada, hacer clic en "Publicar"

## ⏱️ Tiempo de Procesamiento

- **Revisión de la aplicación**: 1-7 días hábiles
- **Publicación**: Inmediata después de la aprobación
- **Disponibilidad en la tienda**: 24-48 horas después de la publicación

## 📋 Checklist de Publicación

- [ ] Cuenta de desarrollador de Google creada
- [ ] Archivo .aab generado y verificado
- [ ] Información de la aplicación completada
- [ ] Capturas de pantalla subidas
- [ ] Política de privacidad creada y subida
- [ ] Clasificación de contenido completada
- [ ] Permisos configurados correctamente
- [ ] Versión enviada para revisión

## 🔧 Solución de Problemas

### Error de Subida del .AAB:
- Verificar que el archivo no esté corrupto
- Regenerar el .aab con `flutter build appbundle --release`
- Verificar que la versión del código sea mayor que la anterior

### Error de Permisos:
- Verificar que todos los permisos estén declarados en `android/app/src/main/AndroidManifest.xml`
- Asegurar que los permisos de Health Connect estén configurados correctamente

### Error de Capturas de Pantalla:
- Verificar que las imágenes cumplan con los requisitos de tamaño
- Asegurar que las capturas muestren la funcionalidad principal

## 📞 Soporte

Si encuentras problemas durante la publicación:
1. Consultar la [documentación oficial de Google Play Console](https://support.google.com/googleplay/android-developer)
2. Revisar los [foros de desarrolladores de Google](https://groups.google.com/g/google-play-developer-community)
3. Contactar al soporte de Google Play Console desde la consola

---

**¡Tu aplicación "Contador de Passos" está lista para ser publicada en Google Play Store!** 🎉 