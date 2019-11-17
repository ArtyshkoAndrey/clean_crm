import Vue from 'vue'
import VueRouter from 'vue-router'
import AuthService from './services/auth'
import Basic from './views/admin/dashboard/Basic.vue'
import TasksIndex from './views/admin/tasks/index.vue'
import Login from './views/auth/Login.vue'
import NotFoundPage from './views/errors/404.vue'
import Home from './views/front/Home.vue'
import LayoutBasic from './views/layouts/LayoutBasic.vue'
import LoginBase from './views/auth/LoginBase.vue'
import LayoutFront from './views/layouts/LayoutFront.vue'

import ProfilePage from './views/admin/profile/index.vue'

import TasksView from './views/admin/tasks/task.vue'
import TasksCreate from './views/admin/tasks/create.vue'
import TasksWorking from './views/admin/tasks/working.vue'
import TasksOverdue from './views/admin/tasks/overdue.vue'
import TasksCompleted from './views/admin/tasks/completed.vue'

import UserIndex from './views/admin/users/index.vue'
import UserCreate from './views/admin/users/create.vue'
import UserView from './views/admin/users/view.vue'
import UserEdit from './views/admin/users/edit.vue'

import RoleAll from './views/admin/roles/all'
import RoleCreate from './views/admin/roles/create'
import RoleView from './views/admin/roles/view'

import DepartmentAll from './views/admin/departments/all'
import DepartmentCreate from './views/admin/departments/create'
import DepartmentView from './views/admin/departments/view'

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
        path: 'task',
        component: {
          render (c) { return c('router-view') }
        },
        children: [
          {
            path: 'all',
            component: TasksIndex,
            name: 'tasks'
          },
          {
            path: 'view/:id',
            component: TasksView,
            name: 'taskView'
          },
          {
            path: 'create',
            component: TasksCreate,
            name: 'taskCreate'
          },
          {
            path: 'working',
            component: TasksWorking,
            name: 'tasksWorking'
          },
          {
            path: 'overdue',
            component: TasksOverdue,
            name: 'tasksOverdue'
          },
          {
            path: 'completed',
            component: TasksCompleted,
            name: 'tasksCompleted'
          }
        ]
      },
      {
        path: 'user',
        component: {
          render (c) { return c('router-view') }
        },
        children: [
          {
            path: '/',
            component: UserIndex,
            name: 'users'
          },
          {
            path: 'create',
            component: UserCreate,
            name: 'userCreate'
          },
          {
            path: ':id',
            component: UserView,
            name: 'userView'
          },
          {
            path: 'edit/:id',
            component: UserEdit,
            name: 'userEdit'
          }
        ]
      },
      {
        path: 'role',
        component: {
          render (c) { return c('router-view') }
        },
        children: [
          {
            path: 'all',
            component: RoleAll,
            name: 'roles'
          },
          {
            path: 'craete',
            component: RoleCreate,
            name: 'roleCreate'
          },
          {
            path: 'view',
            component: RoleView,
            name: 'roleView'
          }
        ]
      },
      {
        path: 'department',
        component: {
          render (c) { return c('router-view') }
        },
        children: [
          {
            path: 'all',
            component: DepartmentAll,
            name: 'departments'
          },
          {
            path: 'create',
            component: DepartmentCreate,
            name: 'departmentCreate'
          },
          {
            path: 'view',
            component: DepartmentView,
            name: 'departmentView'
          }
        ]
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

function hasPermissionsNeeded (to) {
  to.matched.forEach(element => {
    if (window.user.roles.find(role => role.slug === element.meta.role)) {
      return true
    } else {
      return false
    }
  })
}

router.beforeEach((to, from, next) => {
  if (to.matched.some(m => m.meta.requiresAuth)) {
    return AuthService.check().then(authenticated => {
      if (!authenticated) {
        return next({ path: '/login' })
      }
      if (to.matched.some(m => m.meta.role)) {
        if (!hasPermissionsNeeded(to)) {
          next('/admin')
        } else {
          next()
        }
      }
      return next()
    })
  }
  return next()
})

export default router
