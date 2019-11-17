<template>
  <div class="sidebar-left">
    <div class="sidebar-body scroll-pane">
      <div class="side-nav">
        <v-collapse accordion>
          <v-collapse-item active-url="/admin">
            <router-link slot="item-title" to="/admin">
              <i class="icon-fa icon-fa-dashboard"/>Главная
            </router-link>
          </v-collapse-item>

          <v-collapse-item active-url="/admin/task">
            <a slot="item-title" href="#">
              <i class="icon-fa icon-fa-tasks"/>Нарушения
              <span class="icon-fa arrow icon-fa-fw"/>
            </a>
            <router-link to="/admin/task/create">
              Создать
            </router-link>
            <router-link to="/admin/task/all">
              Все
            </router-link>
            <!-- <router-link to="/admin/task/working">
              В работе
            </router-link>
            <router-link to="/admin/task/completed">
              Устраненные
            </router-link>
            <router-link to="/admin/task/overdue">
              Просроченные
            </router-link> -->
          </v-collapse-item>

          <v-collapse-item active-url="/admin/task">
            <a slot="item-title" href="#">
              <i class="icon-fa icon-fa-user"/>Пользователи
              <span class="icon-fa arrow icon-fa-fw"/>
            </a>
            <router-link to="/admin/user/create">
              Создать
            </router-link>
            <router-link to="/admin/user">
              Все
            </router-link>
          </v-collapse-item>

          <!-- <v-collapse-item active-url="/admin/task">
            <a slot="item-title" href="#">
              <i class="icon-fa icon-fa-tasks"/>Уровени доступа
              <span class="icon-fa arrow icon-fa-fw"/>
            </a>
            <router-link to="/admin/role/create">
              Создать
            </router-link>
            <router-link to="/admin/role/all">
              Все
            </router-link>
          </v-collapse-item> -->

          <v-collapse-item active-url="/admin/task">
            <a slot="item-title" href="#">
              <i class="icon-fa icon-fa-building"/>Отделы
              <span class="icon-fa arrow icon-fa-fw"/>
            </a>
            <router-link to="/admin/department/create">
              Создать
            </router-link>
            <router-link to="/admin/department/all">
              Все
            </router-link>
          </v-collapse-item>

          <!-- <v-collapse-item active-url="/admin">
            <router-link slot="item-title" to="/admin">
              <i class="icon-fa icon-fa-dashboard"/>Аналитика
            </router-link>
          </v-collapse-item> -->
        </v-collapse>
      </div>
    </div>
  </div>
</template>
