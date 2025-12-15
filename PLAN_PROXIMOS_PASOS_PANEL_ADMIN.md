# 🚀 PLAN DE PRÓXIMOS PASOS - PANEL ADMINISTRATIVO CAPI

## 📋 RESUMEN EJECUTIVO

El panel administrativo "CAPI Guardian" está **80% implementado** con todas las funcionalidades core funcionando. Este documento define los próximos pasos para completar la implementación y ponerlo en producción.

---

## 🎯 ESTADO ACTUAL

### ✅ **COMPLETADO (80%)**
- **Dashboard Principal**: Métricas, gráficos, alertas
- **Auditoría Completa**: Logs, filtros, modal de detalles
- **Cumplimiento COFEPRIS**: Score, requisitos, métricas ARCO
- **Layout y Navegación**: Header, sidebar, routing
- **Tema CAPI**: Colores, fuentes, responsive design
- **Componentes UI**: shadcn/ui completo, Recharts, Lucide React

### 🔄 **PENDIENTE (20%)**
- **Páginas restantes**: Usuarios, Clínicas, Analytics, Sistema
- **Integración Firebase**: Conexión con base de datos real
- **Autenticación**: Firebase Auth
- **Datos reales**: Reemplazar mock data
- **Deploy**: Publicación en producción

---

## 🚀 FASE 1: INTEGRACIÓN FIREBASE (Semana 1)

### **1.1 Configuración Firebase**
```typescript
// src/lib/firebase.ts
import { initializeApp } from 'firebase/app'
import { getFirestore } from 'firebase/firestore'
import { getAuth } from 'firebase/auth'
import { getStorage } from 'firebase/storage'

const firebaseConfig = {
  projectId: 'capideveloper-6078c',
  // ... resto de configuración CAPI
}

export const app = initializeApp(firebaseConfig)
export const db = getFirestore(app)
export const auth = getAuth(app)
export const storage = getStorage(app)
```

### **1.2 Servicios de API**
```typescript
// src/services/api.ts
export class APIService {
  // Dashboard metrics
  static async getDashboardMetrics() {
    const snapshot = await getDocs(collection(db, 'business_metrics'))
    return snapshot.docs.map(doc => doc.data())
  }

  // Audit logs
  static async getAuditLogs(filters: AuditFilters) {
    let query = collection(db, 'audit_logs')
    // Aplicar filtros
    const snapshot = await getDocs(query)
    return snapshot.docs.map(doc => doc.data())
  }

  // ARCO requests
  static async getARCORequests(filters: ARCOFilters) {
    let query = collection(db, 'arco_requests')
    // Aplicar filtros
    const snapshot = await getDocs(query)
    return snapshot.docs.map(doc => doc.data())
  }
}
```

### **1.3 Hooks de Datos**
```typescript
// src/hooks/useDashboardData.ts
export function useDashboardData() {
  return useQuery({
    queryKey: ['dashboard-metrics'],
    queryFn: APIService.getDashboardMetrics,
    refetchInterval: 30000 // 30 segundos
  })
}

// src/hooks/useAuditLogs.ts
export function useAuditLogs(filters: AuditFilters) {
  return useQuery({
    queryKey: ['audit-logs', filters],
    queryFn: () => APIService.getAuditLogs(filters)
  })
}
```

### **1.4 Variables de Entorno**
```env
# .env.local
VITE_FIREBASE_PROJECT_ID=capideveloper-6078c
VITE_FIREBASE_API_KEY=your-api-key
VITE_FIREBASE_AUTH_DOMAIN=capideveloper-6078c.firebaseapp.com
VITE_FIREBASE_STORAGE_BUCKET=capideveloper-6078c.appspot.com
```

---

## 🔐 FASE 2: AUTENTICACIÓN (Semana 1-2)

### **2.1 Firebase Auth Setup**
```typescript
// src/contexts/AuthContext.tsx
export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<User | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      setUser(user)
      setLoading(false)
    })
    return unsubscribe
  }, [])

  return (
    <AuthContext.Provider value={{ user, loading }}>
      {children}
    </AuthContext.Provider>
  )
}
```

### **2.2 Protección de Rutas**
```typescript
// src/components/ProtectedRoute.tsx
export function ProtectedRoute({ children }: { children: React.ReactNode }) {
  const { user, loading } = useAuth()
  
  if (loading) return <LoadingSpinner />
  if (!user) return <Navigate to="/login" />
  
  return <>{children}</>
}
```

### **3.3 Página de Login**
```typescript
// src/pages/Login.tsx
export function Login() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  
  const handleLogin = async () => {
    try {
      await signInWithEmailAndPassword(auth, email, password)
    } catch (error) {
      toast.error('Error al iniciar sesión')
    }
  }
  
  return (
    <div className="min-h-screen flex items-center justify-center">
      <Card className="w-full max-w-md">
        <CardHeader>
          <CardTitle className="text-center">CAPI Admin</CardTitle>
        </CardHeader>
        <CardContent>
          <form onSubmit={handleLogin}>
            <Input
              type="email"
              placeholder="Email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
            />
            <Input
              type="password"
              placeholder="Contraseña"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
            />
            <Button type="submit" className="w-full">
              Iniciar Sesión
            </Button>
          </form>
        </CardContent>
      </Card>
    </div>
  )
}
```

---

## 👥 FASE 3: PÁGINAS RESTANTES (Semana 2-3)

### **3.1 Gestión de Usuarios**
```typescript
// src/pages/Users.tsx
export function Users() {
  const [users, setUsers] = useState<User[]>([])
  const [filters, setFilters] = useState<UserFilters>({})
  
  return (
    <div className="p-6 space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-3xl font-bold">Gestión de Usuarios</h1>
        <Button>
          <Plus className="h-4 w-4 mr-2" />
          Nuevo Usuario
        </Button>
      </div>
      
      {/* Filtros */}
      <Card>
        <CardContent className="p-6">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
            <Input placeholder="Buscar usuario..." />
            <Select>
              <SelectTrigger>
                <SelectValue placeholder="Rol" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="doctor">Doctor</SelectItem>
                <SelectItem value="asistente">Asistente</SelectItem>
                <SelectItem value="paciente">Paciente</SelectItem>
              </SelectContent>
            </Select>
            <Select>
              <SelectTrigger>
                <SelectValue placeholder="Estado" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="activo">Activo</SelectItem>
                <SelectItem value="inactivo">Inactivo</SelectItem>
                <SelectItem value="suspendido">Suspendido</SelectItem>
              </SelectContent>
            </Select>
            <Button variant="outline">
              <Search className="h-4 w-4 mr-2" />
              Buscar
            </Button>
          </div>
        </CardContent>
      </Card>
      
      {/* Tabla de usuarios */}
      <Card>
        <CardContent className="p-6">
          <Table>
            <TableHeader>
              <TableRow>
                <TableHead>Usuario</TableHead>
                <TableHead>Rol</TableHead>
                <TableHead>Clínica</TableHead>
                <TableHead>Estado</TableHead>
                <TableHead>Último Acceso</TableHead>
                <TableHead>Acciones</TableHead>
              </TableRow>
            </TableHeader>
            <TableBody>
              {users.map((user) => (
                <TableRow key={user.id}>
                  <TableCell>
                    <div className="flex items-center gap-2">
                      <Avatar className="h-8 w-8">
                        <AvatarImage src={user.avatar} />
                        <AvatarFallback>{user.name.charAt(0)}</AvatarFallback>
                      </Avatar>
                      <div>
                        <div className="font-medium">{user.name}</div>
                        <div className="text-sm text-muted-foreground">{user.email}</div>
                      </div>
                    </div>
                  </TableCell>
                  <TableCell>
                    <Badge variant="outline">{user.role}</Badge>
                  </TableCell>
                  <TableCell>{user.clinic}</TableCell>
                  <TableCell>
                    <Badge variant={user.status === 'activo' ? 'default' : 'secondary'}>
                      {user.status}
                    </Badge>
                  </TableCell>
                  <TableCell>{format(user.lastAccess, 'dd/MM/yyyy HH:mm')}</TableCell>
                  <TableCell>
                    <DropdownMenu>
                      <DropdownMenuTrigger asChild>
                        <Button variant="ghost" size="icon">
                          <MoreHorizontal className="h-4 w-4" />
                        </Button>
                      </DropdownMenuTrigger>
                      <DropdownMenuContent>
                        <DropdownMenuItem>Ver Perfil</DropdownMenuItem>
                        <DropdownMenuItem>Editar</DropdownMenuItem>
                        <DropdownMenuItem>Suspendir</DropdownMenuItem>
                        <DropdownMenuItem className="text-error">Eliminar</DropdownMenuItem>
                      </DropdownMenuContent>
                    </DropdownMenu>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </CardContent>
      </Card>
    </div>
  )
}
```

### **3.2 Gestión de Clínicas**
```typescript
// src/pages/Clinics.tsx
export function Clinics() {
  const [clinics, setClinics] = useState<Clinic[]>([])
  
  return (
    <div className="p-6 space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-3xl font-bold">Gestión de Clínicas</h1>
        <Button>
          <Plus className="h-4 w-4 mr-2" />
          Nueva Clínica
        </Button>
      </div>
      
      {/* Métricas por clínica */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        {clinics.map((clinic) => (
          <Card key={clinic.id}>
            <CardHeader>
              <CardTitle className="flex items-center gap-2">
                <Building2 className="h-5 w-5" />
                {clinic.name}
              </CardTitle>
              <CardDescription>{clinic.address}</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="grid grid-cols-2 gap-4">
                <div>
                  <p className="text-sm text-muted-foreground">Usuarios</p>
                  <p className="text-2xl font-bold">{clinic.userCount}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Consultas</p>
                  <p className="text-2xl font-bold">{clinic.consultationCount}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Ingresos</p>
                  <p className="text-2xl font-bold">${clinic.revenue}</p>
                </div>
                <div>
                  <p className="text-sm text-muted-foreground">Compliance</p>
                  <p className="text-2xl font-bold">{clinic.complianceScore}%</p>
                </div>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>
    </div>
  )
}
```

### **3.3 Analytics Avanzados**
```typescript
// src/pages/Analytics.tsx
export function Analytics() {
  return (
    <div className="p-6 space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-3xl font-bold">Analytics Avanzados</h1>
        <div className="flex gap-2">
          <Button variant="outline">
            <Download className="h-4 w-4 mr-2" />
            Exportar
          </Button>
          <Button>
            <RefreshCw className="h-4 w-4 mr-2" />
            Actualizar
          </Button>
        </div>
      </div>
      
      {/* Gráficos avanzados */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <Card>
          <CardHeader>
            <CardTitle>Crecimiento de Usuarios</CardTitle>
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={300}>
              <LineChart data={userGrowthData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="month" />
                <YAxis />
                <Tooltip />
                <Line type="monotone" dataKey="users" stroke="#0EADE0" strokeWidth={2} />
              </LineChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>
        
        <Card>
          <CardHeader>
            <CardTitle>Distribución de Consultas</CardTitle>
          </CardHeader>
          <CardContent>
            <ResponsiveContainer width="100%" height={300}>
              <PieChart>
                <Pie
                  data={consultationDistribution}
                  cx="50%"
                  cy="50%"
                  outerRadius={80}
                  fill="#8884d8"
                  dataKey="value"
                />
                <Tooltip />
              </PieChart>
            </ResponsiveContainer>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}
```

### **3.4 Monitoreo del Sistema**
```typescript
// src/pages/System.tsx
export function System() {
  const [systemHealth, setSystemHealth] = useState<SystemHealth | null>(null)
  
  return (
    <div className="p-6 space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-3xl font-bold">Monitoreo del Sistema</h1>
        <Button>
          <RefreshCw className="h-4 w-4 mr-2" />
          Actualizar
        </Button>
      </div>
      
      {/* Health Status */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <Card>
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">Estado General</p>
                <h3 className="text-2xl font-bold text-success">Operativo</h3>
              </div>
              <Activity className="h-8 w-8 text-success opacity-50" />
            </div>
          </CardContent>
        </Card>
        
        <Card>
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">CPU</p>
                <h3 className="text-2xl font-bold">45%</h3>
              </div>
              <Cpu className="h-8 w-8 text-primary opacity-50" />
            </div>
          </CardContent>
        </Card>
        
        <Card>
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">Memoria</p>
                <h3 className="text-2xl font-bold">67%</h3>
              </div>
              <HardDrive className="h-8 w-8 text-warning opacity-50" />
            </div>
          </CardContent>
        </Card>
        
        <Card>
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-muted-foreground">Storage</p>
                <h3 className="text-2xl font-bold">23%</h3>
              </div>
              <Database className="h-8 w-8 text-info opacity-50" />
            </div>
          </CardContent>
        </Card>
      </div>
      
      {/* Backup Status */}
      <Card>
        <CardHeader>
          <CardTitle>Estado de Backups</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium">Último Backup</p>
                <p className="text-sm text-muted-foreground">15/12/2024 02:00 AM</p>
              </div>
              <Badge variant="outline" className="bg-success/10 text-success">
                Exitoso
              </Badge>
            </div>
            <div className="flex items-center justify-between">
              <div>
                <p className="font-medium">Tamaño</p>
                <p className="text-sm text-muted-foreground">2.3 GB</p>
              </div>
              <div>
                <p className="font-medium">Próximo Backup</p>
                <p className="text-sm text-muted-foreground">16/12/2024 02:00 AM</p>
              </div>
            </div>
          </div>
        </CardContent>
      </Card>
    </div>
  )
}
```

---

## 📊 FASE 4: DATOS REALES (Semana 3-4)

### **4.1 Reemplazar Mock Data**
```typescript
// src/data/mockData.ts → src/data/realData.ts
export const useRealData = () => {
  const { data: dashboardMetrics } = useQuery({
    queryKey: ['dashboard-metrics'],
    queryFn: APIService.getDashboardMetrics
  })
  
  const { data: auditLogs } = useQuery({
    queryKey: ['audit-logs'],
    queryFn: APIService.getAuditLogs
  })
  
  const { data: arcoRequests } = useQuery({
    queryKey: ['arco-requests'],
    queryFn: APIService.getARCORequests
  })
  
  return {
    dashboardMetrics,
    auditLogs,
    arcoRequests
  }
}
```

### **4.2 Optimización de Consultas**
```typescript
// src/hooks/useOptimizedQueries.ts
export function useOptimizedQueries() {
  // Cache de 5 minutos para métricas
  const dashboardQuery = useQuery({
    queryKey: ['dashboard-metrics'],
    queryFn: APIService.getDashboardMetrics,
    staleTime: 5 * 60 * 1000,
    refetchInterval: 30 * 1000
  })
  
  // Cache de 1 minuto para logs
  const auditQuery = useQuery({
    queryKey: ['audit-logs'],
    queryFn: APIService.getAuditLogs,
    staleTime: 1 * 60 * 1000
  })
  
  return {
    dashboard: dashboardQuery,
    audit: auditQuery
  }
}
```

---

## 🚀 FASE 5: DEPLOY Y PRODUCCIÓN (Semana 4)

### **5.1 Configuración de Deploy**
```json
// vercel.json
{
  "buildCommand": "npm run build",
  "outputDirectory": "dist",
  "framework": "vite",
  "env": {
    "VITE_FIREBASE_PROJECT_ID": "@firebase-project-id",
    "VITE_FIREBASE_API_KEY": "@firebase-api-key"
  }
}
```

### **5.2 Variables de Entorno**
```env
# .env.production
VITE_FIREBASE_PROJECT_ID=capideveloper-6078c
VITE_FIREBASE_API_KEY=your-production-api-key
VITE_FIREBASE_AUTH_DOMAIN=capideveloper-6078c.firebaseapp.com
VITE_FIREBASE_STORAGE_BUCKET=capideveloper-6078c.appspot.com
```

### **5.3 Scripts de Deploy**
```json
// package.json
{
  "scripts": {
    "build": "vite build",
    "preview": "vite preview",
    "deploy": "vercel --prod",
    "deploy:staging": "vercel"
  }
}
```

---

## 📋 CRONOGRAMA DETALLADO

### **Semana 1: Integración Firebase**
- **Día 1-2**: Configuración Firebase, servicios API
- **Día 3-4**: Hooks de datos, React Query
- **Día 5**: Testing y debugging

### **Semana 2: Autenticación**
- **Día 1-2**: Firebase Auth, contexto de autenticación
- **Día 3-4**: Protección de rutas, página de login
- **Día 5**: Testing de autenticación

### **Semana 3: Páginas Restantes**
- **Día 1-2**: Gestión de Usuarios
- **Día 3-4**: Gestión de Clínicas, Analytics
- **Día 5**: Monitoreo del Sistema

### **Semana 4: Datos Reales y Deploy**
- **Día 1-2**: Reemplazar mock data, optimización
- **Día 3-4**: Testing completo, debugging
- **Día 5**: Deploy a producción

---

## 🎯 CRITERIOS DE ÉXITO

### **Técnicos**
- ✅ **Performance**: < 3 segundos carga inicial
- ✅ **Responsive**: Mobile, tablet, desktop
- ✅ **Accesibilidad**: WCAG 2.1 AA
- ✅ **Seguridad**: Autenticación robusta

### **Funcionales**
- ✅ **Dashboard**: Métricas en tiempo real
- ✅ **Auditoría**: Logs completos con filtros
- ✅ **Compliance**: Score COFEPRIS actualizado
- ✅ **Gestión**: Usuarios, clínicas, sistema

### **Negocio**
- ✅ **Cumplimiento**: 100% COFEPRIS
- ✅ **Trazabilidad**: Auditoría completa
- ✅ **Usabilidad**: Interface intuitiva
- ✅ **Escalabilidad**: Preparado para crecimiento

---

## 🚨 RIESGOS Y MITIGACIONES

### **Riesgo 1: Integración Firebase**
- **Problema**: Complejidad de conexión con base de datos existente
- **Mitigación**: Testing incremental, rollback plan
- **Contingencia**: Mantener mock data como fallback

### **Riesgo 2: Performance**
- **Problema**: Consultas lentas con datos reales
- **Mitigación**: Optimización de queries, paginación
- **Contingencia**: Cache agresivo, loading states

### **Riesgo 3: Seguridad**
- **Problema**: Acceso no autorizado
- **Mitigación**: Autenticación robusta, permisos granulares
- **Contingencia**: Logs de seguridad, alertas

---

## 📞 CONTACTO Y SOPORTE

**Equipo de Desarrollo CAPI**  
**Email:** dev@capi.com  
**Documentación:** [docs.capi.com](https://docs.capi.com)  
**Soporte:** [support.capi.com](https://support.capi.com)  

---

**Versión del Plan:** 1.0  
**Fecha de creación:** Diciembre 2024  
**Próxima revisión:** Enero 2025  
**Estado:** Aprobado para implementación  

---

*Este plan define los próximos pasos para completar la implementación del Panel Administrativo CAPI, incluyendo integración Firebase, autenticación, páginas restantes, datos reales y deploy a producción.*
