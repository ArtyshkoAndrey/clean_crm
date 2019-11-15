import Vue from 'vue'
import VueRouter from 'vue-router'
import AuthService from './services/auth'
import Basic from './views/admin/dashboard/Basic.vue'
import TasksIndex from './views/admin/tasks/index.vue'
import Login from './views/auth/Login.vue'
import Register from './views/auth/Register.vue'
import NotFoundPage from './views/errors/404.vue'
import Home from './views/front/Home.vue'
import LayoutBasic from './views/layouts/LayoutBasic.vue'
import LoginBase from './views/auth/LoginBase.vue'
import LayoutFront from './views/layouts/LayoutFront.vue'
import TasksView from './views/admin/tasks/task.vue'
import TasksCreate from './views/admin/tasks/create.vue'
import ProfilePage from './views/admin/profile/index.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    component: LayoutFront,
    children: [
      {
        path: '/',
        component: Home,
        name: 'home'
      }
    ]
  },
  {
    path: '/admin',
    component: LayoutBasic,
    meta: { requiresAuth: true },
    children: [
      {
        path: '/',
        component: Basic,
        name: 'dashboard'
      },
      {
        path: 'profile',
        component: ProfilePage,
        name: 'profile'
      },
      {
        path: 'task/all',
        component: TasksIndex,
        name: 'tasks'
      },
      {
        path: 'task/view/:id',
        component: TasksView,
        name: 'taskView'
      },
      {
        path: 'task/create',
        component: TasksCreate,
        name: 'taskCreate'
      }
    ]
  },
  {
    path: '/',
    component: LoginBase,
    children: [
      {
        path: 'login',
        component: Login,
        name: 'login'
      },
      {
        path: 'register',
        component: Register,
        name: 'register'
      }
    ]
  },
  {
    path: '*',
    component: NotFoundPage
  }
]

const router = new VueRouter({
  routes,
  mode: 'history',
  linkActiveClass: 'active'
})

router.beforeEach((to, from, next) => {
  if (to.matched.some(m => m.meta.requiresAuth)) {
    return AuthService.check().then(authenticated => {
      if (!authenticated) {
        return next({ path: '/login' })
      }
      return next()
    })
  }
  return next()
})

export default router
