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

          <v-collapse-item active-url="/admin/tasks">
            <a slot="item-title" href="#">
              <i class="icon-fa icon-fa-tasks"/>Задачи
              <span class="icon-fa arrow icon-fa-fw"/>
            </a>

            <router-link to="/admin/tasks/all">
              Все
            </router-link>
            <router-link to="/admin/tasks/all">
              Просроченные
            </router-link>
          </v-collapse-item>
        </v-collapse>
      </div>
    </div>
  </div>
</template>
