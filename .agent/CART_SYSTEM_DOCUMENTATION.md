# Sistema de Carrito de Compras

## Resumen
Se ha implementado un sistema completo de carrito de compras que permite a los usuarios guardar productos para comprarlos más tarde y retomar su compra desde donde la dejaron.

## Componentes Implementados

### 1. Modelo: `CartItem`
**Archivo**: `lib/core/models/cart_item.dart`

Modelo de datos para representar items en el carrito:
- **id**: Identificador único del item
- **title**: Nombre del producto (ej: "Curva", "General")
- **price**: Precio en formato string (ej: "Bs 300")
- **type**: Tipo de producto ("abono", "producto", etc.)
- **details**: Mapa con todos los detalles del producto
- **addedAt**: Fecha y hora en que se agregó al carrito

#### Características:
- Serialización JSON para persistencia
- Método `numericPrice` para extraer el valor numérico del precio
- Conversión bidireccional JSON ↔ CartItem

### 2. Servicio: `CartService`
**Archivo**: `lib/core/services/cart_service.dart`

Servicio singleton para gestionar el carrito:

#### Métodos principales:
```dart
getCartItems()          // Obtiene todos los items del carrito
addItem(CartItem)       // Agrega o actualiza un item
removeItem(String id)   // Elimina un item por ID
clearCart()             // Vacía todo el carrito
getItemCount()          // Número de items en el carrito
getTotal()              // Calcula el precio total
isInCart(String id)     // Verifica si un item está en el carrito
getItem(String id)      // Obtiene un item específico
```

#### Características:
- **Persistencia**: Usa `SharedPreferences` para guardar el carrito
- **Singleton**: Una única instancia en toda la app
- **Manejo de errores**: Si hay error al decodificar, limpia el carrito
- **Actualización automática**: Si un item ya existe, lo reemplaza

### 3. Pantalla: `CartScreen`
**Archivo**: `lib/presentation/screens/cart_screen.dart`

Pantalla completa para visualizar y gestionar el carrito:

#### Funcionalidades:
1. **Vista de items**: Lista todos los productos guardados
2. **Eliminar items**: Botón para eliminar items individuales
3. **Vaciar carrito**: Opción para eliminar todos los items (con confirmación)
4. **Continuar compra**: Botón para retomar la compra de un item
5. **Estado vacío**: Mensaje amigable cuando no hay items
6. **Resumen**: Muestra el total y cantidad de productos

#### Características de UI:
- Card personalizado para cada item
- Iconos visuales (abono, producto)
- Precio destacado
- Botones de acción (Eliminar / Continuar compra)
- Badge con contador en el AppBar
- Confirmación antes de vaciar el carrito

### 4. Integración en `StoreScreen`
**Archivo**: `lib/presentation/screens/store_screen.dart`

Se agregaron las siguientes funcionalidades:

#### Botón de carrito con badge:
- Icono de carrito en el AppBar
- Badge rojo con el número de items
- Navegación a `CartScreen` al hacer clic
- Actualización automática del contador

#### Botón "Guardar para después":
- Icono de bookmark en cada tarjeta de producto
- Agrega el producto al carrito sin iniciar la compra
- SnackBar de confirmación con acción "Ver carrito"
- Actualiza el contador automáticamente

## Flujo de Usuario

### Escenario 1: Guardar producto para después
1. Usuario navega a la **Tienda**
2. Ve un abono que le interesa pero no quiere comprarlo ahora
3. Hace clic en el **icono de bookmark** (guardar)
4. Aparece SnackBar: "Curva guardado en el carrito"
5. El **badge del carrito** se actualiza: muestra "1"
6. Puede continuar navegando o hacer clic en "Ver carrito"

### Escenario 2: Ver y gestionar el carrito
1. Usuario hace clic en el **icono del carrito** en el AppBar
2. Se abre `CartScreen` mostrando todos los items guardados
3. Puede ver:
   - Nombre del producto
   - Precio
   - Fecha de agregado (implícito)
4. Opciones disponibles:
   - **Eliminar**: Quita el item del carrito
   - **Continuar compra**: Va a `PurchaseDetailScreen`
   - **Vaciar carrito**: Elimina todos los items (con confirmación)

### Escenario 3: Retomar compra guardada
1. Usuario abre el carrito
2. Ve el producto "General - Bs 500" que guardó ayer
3. Hace clic en **"Continuar compra"**
4. Se abre `PurchaseDetailScreen` con todos los datos del producto
5. Puede completar la compra desde donde la dejó

### Escenario 4: Carrito vacío
1. Usuario abre el carrito sin items guardados
2. Ve un mensaje amigable: "Tu carrito está vacío"
3. Icono grande de carrito vacío
4. Botón **"Ir a la tienda"** para volver a comprar

## Persistencia de Datos

### Almacenamiento
- Los items se guardan en `SharedPreferences`
- Clave: `'shopping_cart'`
- Formato: JSON array de CartItems
- Persiste entre sesiones de la app

### Sincronización
- El carrito se carga al abrir `CartScreen`
- El contador se actualiza al:
  - Agregar un item
  - Eliminar un item
  - Volver de `CartScreen`
  - Iniciar `StoreScreen`

## Características Técnicas

### Manejo de Estado
- `StatefulWidget` con estado local
- Recarga automática después de operaciones
- Indicador de carga mientras se obtienen datos

### Validaciones
- Verifica si el item ya existe antes de agregar
- Manejo de errores al decodificar JSON
- Confirmación antes de acciones destructivas

### UX/UI
- SnackBars informativos
- Diálogos de confirmación
- Estados vacíos bien diseñados
- Feedback visual inmediato
- Navegación fluida

## Mejoras Futuras Sugeridas

1. **Múltiples items en checkout**: Permitir comprar varios items a la vez
2. **Favoritos vs Carrito**: Separar items favoritos de items para comprar
3. **Notificaciones**: Recordar al usuario sobre items en el carrito
4. **Expiración**: Limpiar items antiguos automáticamente
5. **Sincronización en la nube**: Guardar el carrito en un backend
6. **Cantidades**: Permitir múltiples unidades del mismo producto
7. **Wishlist**: Lista de deseos separada del carrito
8. **Comparación**: Comparar diferentes abonos antes de comprar

## Archivos Creados/Modificados

### Nuevos archivos:
1. ✅ `lib/core/models/cart_item.dart`
2. ✅ `lib/core/services/cart_service.dart`
3. ✅ `lib/presentation/screens/cart_screen.dart`

### Archivos modificados:
1. ✅ `lib/presentation/screens/store_screen.dart`
   - Agregado badge de carrito
   - Agregado botón "Guardar para después"
   - Integración con CartService

## Testing Manual

Para probar la funcionalidad:

1. **Agregar al carrito**:
   - Ir a Tienda
   - Hacer clic en el icono de bookmark de cualquier abono
   - Verificar que aparece el SnackBar
   - Verificar que el badge muestra "1"

2. **Ver carrito**:
   - Hacer clic en el icono del carrito
   - Verificar que se muestra el item guardado
   - Verificar que el precio y nombre son correctos

3. **Eliminar item**:
   - En el carrito, hacer clic en "Eliminar"
   - Verificar que el item desaparece
   - Verificar que el badge se actualiza

4. **Continuar compra**:
   - Guardar un item en el carrito
   - Abrir el carrito
   - Hacer clic en "Continuar compra"
   - Verificar que se abre PurchaseDetailScreen con los datos correctos

5. **Persistencia**:
   - Agregar items al carrito
   - Cerrar la app (refrescar navegador)
   - Volver a abrir
   - Verificar que los items siguen en el carrito

## Beneficios

✅ **Experiencia mejorada**: Los usuarios pueden guardar productos sin perder su selección
✅ **Conversión aumentada**: Reduce la fricción en el proceso de compra
✅ **Persistencia**: Los datos se mantienen entre sesiones
✅ **Flexibilidad**: Los usuarios pueden comparar y decidir después
✅ **Código limpio**: Arquitectura bien organizada y mantenible
✅ **Escalable**: Fácil agregar nuevos tipos de productos al carrito
