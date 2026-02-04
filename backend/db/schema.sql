-- =====================================================
-- Esquema de Base de Datos
-- Sistema de Monitoreo y Análisis de Ventas
-- =====================================================

-- =========================
-- Tabla: Producto
-- =========================
CREATE TABLE producto (
    producto_id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(150) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    costo NUMERIC(10,2) NOT NULL,
    precio_unitario NUMERIC(10,2) NOT NULL,
    fecha_caducidad DATE
);

-- =========================
-- Tabla: Venta
-- =========================
CREATE TABLE venta (
    venta_id SERIAL PRIMARY KEY,
    fecha_venta TIMESTAMP NOT NULL,
    ticket_id VARCHAR(50) NOT NULL,
    sucursal VARCHAR(100) NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    total_venta NUMERIC(12,2) NOT NULL
);

-- =========================
-- Tabla: DetalleVenta
-- =========================
CREATE TABLE detalle_venta (
    detalle_id SERIAL PRIMARY KEY,
    venta_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC(10,2) NOT NULL,
    subtotal NUMERIC(12,2) NOT NULL,
    CONSTRAINT fk_detalle_venta
        FOREIGN KEY (venta_id)
        REFERENCES venta (venta_id),
    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (producto_id)
        REFERENCES producto (producto_id)
);

-- =========================
-- Tabla: Inventario
-- =========================
CREATE TABLE inventario (
    inventario_id SERIAL PRIMARY KEY,
    producto_id INTEGER UNIQUE NOT NULL,
    stock_actual INTEGER NOT NULL CHECK (stock_actual >= 0),
    stock_minimo INTEGER NOT NULL CHECK (stock_minimo >= 0),
    ultima_actualizacion TIMESTAMP NOT NULL,
    CONSTRAINT fk_inventario_producto
        FOREIGN KEY (producto_id)
        REFERENCES producto (producto_id)
);

-- =========================
-- Tabla: MovimientoInventario
-- =========================
CREATE TABLE movimiento_inventario (
    movimiento_id SERIAL PRIMARY KEY,
    producto_id INTEGER NOT NULL,
    tipo_movimiento VARCHAR(20) NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    fecha_movimiento TIMESTAMP NOT NULL,
    referencia VARCHAR(100),
    CONSTRAINT fk_movimiento_producto
        FOREIGN KEY (producto_id)
        REFERENCES producto (producto_id)
);

-- =========================
-- Tabla: Usuario
-- =========================
CREATE TABLE usuario (
    usuario_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    rol VARCHAR(50) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
);

-- =========================
-- Tabla: LogAcceso
-- =========================
CREATE TABLE log_acceso (
    log_id SERIAL PRIMARY KEY,
    usuario_id INTEGER NOT NULL,
    fecha_acceso TIMESTAMP NOT NULL,
    accion VARCHAR(100) NOT NULL,
    ip_origen VARCHAR(50),
    CONSTRAINT fk_log_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuario (usuario_id)
);

-- =========================
-- Tabla: Promocion
-- =========================
CREATE TABLE promocion (
    promocion_id SERIAL PRIMARY KEY,
    producto_id INTEGER NOT NULL,
    tipo_descuento VARCHAR(50) NOT NULL,
    valor_descuento NUMERIC(5,2) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    CONSTRAINT fk_promocion_producto
        FOREIGN KEY (producto_id)
        REFERENCES producto (producto_id)
);

-- =========================
-- Tabla: CargaDatos
-- =========================
CREATE TABLE carga_datos (
    carga_id SERIAL PRIMARY KEY,
    archivo VARCHAR(150) NOT NULL,
    fecha_carga TIMESTAMP NOT NULL,
    registros_procesados INTEGER,
    estado VARCHAR(50) NOT NULL,
    errores TEXT
);
