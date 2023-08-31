# PetSos - Aplicación de Predicción de Enfermedades para Mascotas


PetHealth Predictor es una aplicación móvil desarrollada en Flutter con Dart y Firebase que tiene como objetivo ayudarte a determinar posibles enfermedades en tu mascota a través de un sencillo formulario. La aplicación utiliza un algoritmo de predicción para categorizar la enfermedad como "grave" o "leve". En función de la gravedad, proporciona recomendaciones para acciones a seguir, ya sea ubicando clínicas veterinarias cercanas en un mapa o brindando soluciones para tratar la enfermedad en casa.


## Características

- **Formulario de Síntomas:** Proporciona un formulario intuitivo en el que los usuarios pueden ingresar los síntomas observados en su mascota.

- **Predicción de Enfermedad:** Utiliza un algoritmo basado en datos para predecir la posible enfermedad de la mascota y la categoriza como "grave" o "leve".

- **Recomendaciones Personalizadas:** Ofrece recomendaciones específicas según la gravedad de la enfermedad. Si es "grave", muestra un mapa con las clínicas veterinarias cercanas; si es "leve", proporciona soluciones para tratar la enfermedad desde casa.

- **Integración con Firebase:** Utiliza Firebase para almacenar y gestionar los datos de los usuarios, así como para sincronizar los resultados de las predicciones en diferentes dispositivos.

## Instalación

1. Clona este repositorio en tu máquina local usando `git clone https://github.com/tu-usuario/PetHealth-Predictor.git`

2. Asegúrate de tener Flutter instalado. Si no, sigue las instrucciones en [flutter.dev](https://flutter.dev/docs/get-started/install)

3. Configura tu proyecto en [Firebase Console](https://console.firebase.google.com/) y reemplaza el archivo de configuración `google-services.json` en la carpeta `android/app` con el generado para tu proyecto.

4. Ejecuta la aplicación usando `flutter run`

## Contribución

Si deseas contribuir a PetHealth Predictor, sigue estos pasos:

1. Realiza un fork de este repositorio

2. Crea una rama para tu función: `git checkout -b nueva-funcion`

3. Realiza tus cambios y commitea: `git commit -m 'Agrega una nueva función'`

4. Envía tus cambios al repositorio remoto: `git push origin nueva-funcion`

5. Abre una solicitud pull en este repositorio.

## Licencia

Este proyecto está bajo la Licencia XYZ. Consulta el archivo [LICENSE](LICENSE) para obtener más información.

---
