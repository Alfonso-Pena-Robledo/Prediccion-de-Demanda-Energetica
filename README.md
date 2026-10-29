# ⚡ Pipeline de Predicción de Demanda Eléctrica (PJM) 

Este proyecto implementa una solución completa de ingeniería de datos y modelado predictivo para la **predicción de la demanda eléctrica horaria** utilizando el histórico del sistema **PJM Interconnection** (dataset *PJME*). El flujo de trabajo cubre desde el procesamiento distribuido a gran escala con **PySpark** y almacenamiento optimizado en **Apache Parquet**, hasta el entrenamiento de modelos de Machine Learning y Deep Learning (**Random Forest** y redes **LSTM**).

---

## 🏗️ 1. Arquitectura del Proyecto y Flujo de Trabajo (Pipeline)

El desarrollo del proyecto se divide en 7 etapas clave para garantizar la escalabilidad, la limpieza de los datos y la precisión predictiva:

1. **Ingesta y Configuración Distribuida (`SparkSession`):** Inicialización de una sesión de Spark optimizada para ejecución local aprovechando todos los núcleos de procesamiento disponibles (`local[*]`).
2. **Extracción y Limpieza de Datos (ETL con PySpark):** Lectura del archivo CSV original, conversión de marcas de tiempo, casteo de tipos de datos (`double`), filtrado de nulos/valores anómalos (consumo menor o igual a cero) y eliminación de registros duplicados por fecha.
3. **Ingeniería de Características Temporal (Feature Engineering):** Generación de variables temporales clave (hora, día de la semana, indicador de fin de semana, mes, año) y cálculo de características avanzadas de desfase (*lags* de 24 horas) y medias móviles temporales (ventana deslizante de 7 días / 168 horas) utilizando especificaciones de ventana (`Window`).
4. **Persistencia Optimizada (Apache Parquet):** Almacenamiento estructurado de los datos limpios y enriquecidos en formato columnar **Parquet**, particionados físicamente por `year` y `month` para maximizar la eficiencia en futuras consultas analíticas.
5. **Preparación de Secuencias y Prevención de *Data Leakage*:** Carga de los datos a Pandas/NumPy, división cronológica estricta (80% entrenamiento, 20% prueba para respetar la naturaleza de las series temporales), normalización con `MinMaxScaler` ajustado exclusivamente sobre el conjunto de entrenamiento, y estructuración en ventanas deslizantes de secuencias de 24 horas.
6. **Modelado Predictivo Dual (Machine Learning & Deep Learning):**
   * **Random Forest Regressor:** Modelo de ensamblaje optimizado con hiperparámetros controlados (`max_depth=15`, `n_estimators=100`) sobre secuencias aplanadas.
   * **Red Neuronal LSTM (TensorFlow/Keras):** Red recurrente profunda con capas ocultas (64 y 32 unidades) y capas de *Dropout* (0.2) para mitigar el sobreajuste (*overfitting*), utilizando un callback de `EarlyStopping` monitorizando la pérdida de validación.
7. **Evaluación de Rendimiento y Visualización Comparativa:** Medición de errores predictivos mediante RMSE (*Root Mean Squared Error*) y MAE (*Mean Absolute Error*), acompañada de una interfaz gráfica comparativa generada con Seaborn y Matplotlib para analizar el comportamiento real frente a las predicciones en el horizonte de prueba.

---

## 🛠️ 2. Tecnologías y Librerías Utilizadas

* **Procesamiento Big Data:** Apache Spark (PySpark), Apache Parquet.
* **Manipulación y Análisis de Datos:** Pandas, NumPy.
* **Machine Learning:** Scikit-Learn (`RandomForestRegressor`, `MinMaxScaler`, métricas de evaluación).
* **Deep Learning:** TensorFlow & Keras (`Sequential`, `LSTM`, `Dense`, `Dropout`, `EarlyStopping`).
* **Visualización:** Matplotlib, Seaborn.

---

## 🚀 3. Instrucciones de Ejecución

1. **Clonar el repositorio y asegurar dependencias:**
   ```bash
   pip install pyspark scikit-learn tensorflow pandas numpy matplotlib seaborn
   ```
2. **Colocar el dataset fuente** (`pjme_extracted.csv`) en el directorio raíz del proyecto.
3. **Ejecutar el cuaderno o script principal** en un entorno compatible (como Google Colab o un entorno local de Spark/Python) para replicar la canalización ETL, el entrenamiento de los modelos y la generación de gráficos comparativos.
