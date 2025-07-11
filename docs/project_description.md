# Torneos UdeA – Definición de Proyecto

## 1. Descripción

Aplicación móvil para gestionar los torneos deportivos internos de la Universidad de Antioquia. En la primera versión solo se soportarán tres deportes: **Baloncesto**, **Fútbol** y **Voleibol**.

## 2. Objetivo

Facilitar a estudiantes y organizadores la inscripción, programación y consulta de resultados de los torneos universitarios.

## 3. Personas y Roles

| Rol                       | Descripción                                                    | Requiere login |
| ------------------------- | -------------------------------------------------------------- | -------------- |
| Organizador/Administrador | Usuario con permisos totales para gestionar torneos y equipos. | Sí             |
| Espectador                | Cualquier persona que consulta información de torneos.         | No             |

### 3.1 Permisos por Rol

#### Organizador/Administrador

- Gestión completa de torneos:
  - Crear, editar y eliminar torneos
  - Definir fechas, categorías y reglas
- Gestión de equipos:
  - Crear y editar equipos
  - Agregar/eliminar integrantes
  - Asignar equipos a torneos
- Gestión de partidos:
  - Actualizar resultados
  - Modificar brackets/llaves/eliminatorias
  - Programar fechas de juegos
- Gestión de documentos:
  - Publicar reglamentos
  - Emitir resoluciones y comunicados

#### Espectador

- Visualización de información:
  - Ver torneos activos
  - Consultar equipos y sus integrantes
  - Ver brackets y resultados
  - Consultar calendario de partidos
  - Acceder a reglamentos y resoluciones

## 4. Secciones (Navegación principal)

1. **Torneos** – Lista y filtro de torneos disponibles.

   - Filtros por deporte, estado (activo/finalizado)
   - Detalles del torneo (fechas, categorías, equipos participantes)

2. **Equipos** – Detalle de equipos por torneo.

   - Lista de equipos
   - Información de integrantes
   - Estadísticas del equipo en el torneo

3. **Cuadros** – Llaves/brackets y eliminatorias.

   - Visualización de brackets
   - Resultados de partidos
   - Progreso del torneo

4. **Programación** – Calendario de partidos.

   - Calendario con próximos partidos
   - Historial de partidos jugados
   - Filtros por fecha y equipo

5. **Reglamento** – Documento oficial de reglas.

   - Reglamento general
   - Reglas específicas por deporte
   - Sistemas de juego

6. **Resoluciones** – Comunicados y sanciones.
   - Comunicados oficiales
   - Sanciones disciplinarias
   - Modificaciones al torneo

## 5. Modelos

### Torneo

```dart
{
  id: String,               // ID único del torneo
  nombre: String,           // Nombre del torneo
  deporte: Enum {          // Tipo de deporte
    FUTBOL,
    BALONCESTO,
    VOLEIBOL
  },
  metodoEliminacion: Enum { // Sistema de juego
    ELIMINACION_DIRECTA,
    GRUPOS,
    TODOS_CONTRA_TODOS
  },
  cantidadEquipos: int,     // Número total de equipos
  estado: Enum {           // Estado actual del torneo
    REGISTRO,
    EN_PROGRESO,
    FINALIZADO
  },
  fechaInicioRegistro: DateTime,
  fechaFinRegistro: DateTime,
  fechaInicioTorneo: DateTime,
  fechaFinTorneo: DateTime,
  createdAt: DateTime,      // Fecha de creación
  updatedAt: DateTime,      // Última actualización
  createdBy: String,        // ID del administrador que lo creó
}
```

### Equipo

```dart
{
  id: String,              // ID único del equipo
  nombre: String,          // Nombre del equipo
  torneoId: String,        // Referencia al torneo
  capitan: String,         // Nombre del capitán
  facultad: String,        // Facultad que representa
  integrantes: [           // Lista de jugadores
    {
      nombre: String,
      documento: String,   // Documento de identidad
      numeroCamiseta: int,
      posicion: String?,   // Opcional, depende del deporte
    }
  ],
  createdAt: DateTime,
}
```

<!-- ### Partido

```dart
{
  id: String,              // ID único del partido
  torneoId: String,        // Referencia al torneo
  equipoLocalId: String,   // ID del equipo local
  equipoVisitanteId: String, // ID del equipo visitante
  fechaProgramada: DateTime, // Fecha y hora programada
  fechaJugado: DateTime?,   // Fecha real cuando se jugó (opcional)
  estado: Enum {           // Estado del partido
    PROGRAMADO,
    EN_PROGRESO,
    FINALIZADO,
    CANCELADO,
    SUSPENDIDO
  },
  resultado: {             // Resultado del partido (opcional hasta finalizar)
    golesLocal: int?,      // Goles del equipo local
    golesVisitante: int?,  // Goles del equipo visitante
    ganador: String?,      // ID del equipo ganador (null si empate)
    empate: bool,          // Indica si fue empate
  },
  fase: Enum {            // Fase del torneo
    GRUPO,
    OCTAVOS,
    CUARTOS,
    SEMIFINAL,
    FINAL,
    TERCER_LUGAR
  },
  numeroFase: int,        // Número de la fase (ej: grupo 1, grupo 2)
  numeroPartido: int,     // Número del partido en la fase
  createdAt: DateTime,     // Fecha de creación
  updatedAt: DateTime,    // Última actualización
  createdBy: String       // ID del administrador que lo creó
}
``` -->

### Usuario

```dart
{
  id: String,              // ID único del usuario
  nombre: String,          // Nombre completo del usuario
  email: String,           // Email único del usuario
  rol: Enum {             // Rol del usuario
    ADMIN,
    USER
  },
  activo: bool,           // Estado del usuario
  createdAt: DateTime,     // Fecha de creación
  updatedAt: DateTime,    // Última actualización
}
```
