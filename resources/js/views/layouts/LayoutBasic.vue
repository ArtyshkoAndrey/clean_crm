<template>
  <div class="template-container">
    <site-header/>
    <site-sidebar type="basic"/>
    <transition name="fade" mode="out-in">
      <router-view/>
    </transition>
    <site-footer/>
  </div>
</template>
<script type="text/babel">
import SiteHeader from './partials/TheSiteHeader.vue'
import SiteFooter from './partials/TheSiteFooter.vue'
import SiteSidebar from './partials/TheSiteSidebar.vue'

export default {
  components: {
    SiteHeader, SiteSidebar, SiteFooter
  },
  mounted () {
    // {title: 'Skin - Lannister', 'slug': 'lannister', 'img': '/assets/img/skins/skin-lannister.png', 'light': true}
    // this.$utils.setLayout('default')
    this.$utils.setSkin('lannister')
    // this.$utils.setLogo('/assets/img/logo_white.png')
  }
}
</script>
