# 📋 AutoHotkey Text Selector

> **Script de productividad para AutoHotkey v2 que permite insertar rápidamente textos predefinidos en cualquier aplicación con una interfaz de doble nivel intuitiva.**

[![AutoHotkey](https://img.shields.io/badge/AutoHotkey-v2.0-blue.svg)](https://www.autohotkey.com/v2/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](#license)
[![Platform](https://img.shields.io/badge/Platform-Windows-lightgrey.svg)](https://www.microsoft.com/windows)

## 🎯 Características

- **🚀 Activación global**: `Win + Espacio` desde cualquier aplicación
- **📊 Interfaz de doble nivel**: Categoría → Opción específica
- **📝 Soporte completo de formato**: Saltos de línea, texto multilínea
- **⚡ Pegado inteligente**: Utiliza el clipboard del sistema de forma óptima
- **🔧 Totalmente personalizable**: Datos en CSV fácil de editar
- **🎨 Interfaz Always-On-Top**: Sin interrupciones en tu flujo de trabajo

## 📥 Instalación

1. **Descarga e instala AutoHotkey v2**: [AutoHotkey Official Site](https://www.autohotkey.com/v2/)

2. **Clona este repositorio**:
   ```bash
   git clone https://github.com/eugeniodc/autohotkey-text-selector.git
   cd autohotkey-text-selector
   ```

3. **Ejecuta el script**:
   - Doble clic en `script.ahk` para ejecución temporal
   - O colócalo en tu carpeta de inicio para ejecución automática

## 🚀 Uso Rápido

1. **Activa el selector**: `Win + Espacio` en cualquier aplicación
2. **Selecciona categoría**: Exchange, Respuesta, Datos, Enlaces, etc.
3. **Elige opción específica**: Email formal, Chat, Teléfono, etc.
4. **Pega**: Botón "Pegar" o `Enter`
5. **¡Listo!**: El texto se inserta con formato correcto

### 📸 Demo de Uso

```
Win + Espacio → Exchange → OnPremise → Enter
```
**Resultado:**
```
Estimado/a [Nombre]:

Espero que te encuentres bien.
```

## 📁 Estructura de Archivos

```
autohotkey-text-selector/
├── 📄 script.ahk          # Script principal
├── 📊 Textos.csv          # Base de datos de textos
├── 📖 README.md           # Este archivo
├── 📋 LICENSE             # Licencia MIT
└── 📁 docs/               # Documentación adicional
    ├── 🛠️ customization.md  # Guía de personalización
    └── 🔧 troubleshooting.md # Solución de problemas
```

## 🔧 Personalización

### Agregar/Modificar Textos

Edita `Textos.csv` con el formato:
```csv
Categoría|Opción|Texto
```

**Ejemplos:**

```csv
Exchange|OnPremise|Estimado/a [Nombre]:`r`n`r`nEspero que te encuentres bien.
Datos|Email|mi.correo.profesional@empresa.com
Enlaces|Web Personal|https://www.miweb.com
```

### Saltos de Línea

Para incluir saltos de línea en tus textos, usa `\`r\`n`:

```csv
Saludo|Formal|Buenos días,`r`n`r`nEspero que estés bien.
```

### Cambiar Hotkey

En `script.ahk`, modifica la línea:
```autohotkey
#Space:: MostrarSelectorDeTexto()  ; Win + Espacio
```

**Alternativas populares:**
- `^j::` → `Ctrl + J`
- `!t::` → `Alt + T`  
- `F12::` → `Tecla F12`

## 📊 Categorías de Ejemplo

| Categoría | Opciones | Descripción |
|-----------|----------|-------------|
| **Exchange** | OnPremise, Email Rápido, Chat | Comunicaciones de Exchange |
| **Respuesta** | Confirmación, En Revisión | Respuestas estándar |
| **Datos** | Email, Teléfono | Información de contacto |
| **Enlaces** | Web Personal, Documentos | URLs frecuentes |

## 🛠️ Requisitos del Sistema

- **OS**: Windows 7/8/10/11
- **AutoHotkey**: v2.0 o superior
- **Memoria**: Mínimo 50 MB RAM
- **Disco**: 1 MB de espacio libre

## 🔍 Solución de Problemas

### Script no se ejecuta
- ✅ Verificar AutoHotkey v2 instalado
- ✅ Ejecutar como administrador si es necesario

### Textos no se pegan
- ✅ Verificar formato CSV correcto
- ✅ Comprobar que `Textos.csv` existe en la misma carpeta

### Saltos de línea no funcionan
- ✅ Usar `\`r\`n` en lugar de `\n` en el CSV
- ✅ Verificar codificación UTF-8 del archivo CSV

## 🤝 Contribuir

¡Las contribuciones son bienvenidas! 

1. **Fork** el repositorio
2. **Crear** rama feature (`git checkout -b feature/nueva-funcionalidad`)
3. **Commit** cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. **Push** a la rama (`git push origin feature/nueva-funcionalidad`)
5. **Crear** Pull Request

### 💡 Ideas para Contribuir

- [ ] Interfaz de configuración GUI
- [ ] Soporte para imágenes/multimedia
- [ ] Integración con gestores de contraseñas
- [ ] Historial de textos usados
- [ ] Categorías anidadas (más de 2 niveles)

## 📄 Licencia

Este proyecto está licenciado bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para detalles.

## 🙏 Reconocimientos

- [AutoHotkey Community](https://www.autohotkey.com/boards/) por la excelente documentación
- Inspirado en herramientas de productividad como TextExpander y PhraseExpress

## 📞 Soporte

- **Issues**: [GitHub Issues](https://github.com/eugeniodc/autohotkey-text-selector/issues)
- **Documentación**: [Wiki del proyecto](https://github.com/eugeniodc/autohotkey-text-selector/wiki)
- **AutoHotkey Docs**: [Documentación oficial v2](https://www.autohotkey.com/docs/v2/)

---

⭐ **¿Te resulta útil?** ¡Dale una estrella al repositorio!

📝 **Última actualización**: Noviembre 2025