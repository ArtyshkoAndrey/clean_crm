<template>
  <div class="template-container">
    <header class="site-header">
      <div class="row">
        <div class="col hidden-sm-down">
          <a href="#" class="brand-main">
            <h3 class="hidden-sm-down text-white">CLEAN CRM</h3>
          </a>
        </div>
        <div class="col">
          <ul class="action-list">
            <li class="action-item">
              <router-link to="/admin">Dashboard</router-link>
            </li>
          </ul>
        </div>
      </div>
    </header>
    <transition
      name="fade"
      mode="out-in">
      <router-view/>
    </transition>
  </div>
</template>
