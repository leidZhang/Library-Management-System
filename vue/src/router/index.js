import Vue from 'vue'
import VueRouter from 'vue-router'
import HomeView from '../views/home/HomeView.vue'
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
      }
    ]
  },

]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
