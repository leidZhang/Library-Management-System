import Vue from 'vue'
import VueRouter from 'vue-router'
import Cookies from "js-cookie";
import Layout from "@/views/Layout";

Vue.use(VueRouter)

const routes = [
  // ===== login =====
  {
    path: '/login',
    name: 'login',
    component: () => import('@/views/login/Login')
  },
  // ===== layout =====
  {
    path: '/',
    name: 'layout',
    redirect: 'home',
    component: Layout,
    children: [
      // ===== homepage =====
      {
        path: 'home',
        name: 'home',
        component: () => import('@/views/home/HomeView')
      },
      // ===== user list =====
      {
        path: 'userList',
        name: 'userList',
        // route level code-splitting
        // this generates a separate chunk (about.[hash].js) for this route
        // which is lazy-loaded when the route is visited.
        component: () => import(/* webpackChunkName: "about" */ '@/views/user/List')
      },
      // ===== add user =====
      {
        path: 'addUser',
        name: 'addUser',
        component: () => import('@/views/user/Add')
      },
      // ====== edit user =====
      {
        path: 'editUser',
        name: 'editUser',
        component: () => import('@/views/user/Edit')
      },
      // ===== admin list =====
      {
        path: 'adminList',
        name: 'adminList',
        component: () => import('@/views/admin/List')
      },
      // ===== add admin =====
      {
        path: 'addAdmin',
        name: 'addAdmin',
        component: () => import('@/views/admin/Add')
      },
      // ===== edit admin =====
      {
        path: 'editAdmin',
        name: 'editAdmin',
        component: () => import('@/views/admin/Edit')
      },
      // ===== category =====
      {
        path: 'categoryList',
        name: 'categoryList',
        component: () => import('@/views/category/List')
      },
      {
        path: 'addCategory',
        name: 'addCategory',
        component: () => import('@/views/category/Add')
      },
      {
        path: 'editCategory',
        name: 'editCategory',
        component: () => import('@/views/category/Edit')
      },
      // ===== book =====
      {
        path: 'bookList',
        name: 'bookList',
        component: () => import('@/views/book/List')
      },
      {
        path: 'addBook',
        name: 'addBook',
        component: () => import('@/views/book/Add')
      },
      {
        path: 'editBook',
        name: 'editBook',
        component: () => import('@/views/book/Edit')
      },
      // ===== borrow =====
      {
        path: 'borrowList',
        name: 'borrowList',
        component: () => import('@/views/borrow/List')
      },
      {
        path: 'addBorrow',
        name: 'addBorrow',
        component: () => import('@/views/borrow/Add')
      },
      // ===== return =====
      {
        path: 'reternList',
        name: 'reternList',
        component: () => import('@/views/retern/List')
      }
    ]
  },
  // ===== 404 =====
  {
    path: '*',
    component: () => import('@/views/404')
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.beforeResolve((to, from, next) => {
  if (to.path === '/login') next()
  const admin = Cookies.get("admin")
  if (!admin && to.path !== '/login') return next('/login')
  next()
})

export default router
