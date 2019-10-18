<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-header">
            <h6><i class="icon-fa icon-fa-clock-o text-danger" />Просроченные задачи</h6>
          </div>
          <div class="card-body">
            <table class="table table-hover">
              <thead>
                <tr>
                  <th></th>
                  <th>Адрес</th>
                  <th>Дата выявления</th>
                  <th class="d-none d-md-table-cell">Описание проблемы</th>
                  <th class="d-none d-md-table-cell">Контрольный срок</th>
                </tr>
              </thead>
              <tbody v-if="count > 0">
                <tr>
                  <td>
                    <div style="height: 50px; width: 50px" class="text-center">
                        <i class="icon-fa icon-fa-ellipsis-h" style="height: 25px" />
                    </div>
                  </td>
                  <td>ул. Горького 24</td>
                  <td>23.05.2019</td>
                  <td class="d-none d-md-table-cell">На дереве целлофан</td>
                  <td class="d-none d-md-table-cell">23.04.2019</td>
                </tr>
                <tr>
                  <td>
                    <button class="btn btn-default">:</button>
                  </td>
                  <td>ул. Горького 25</td>
                  <td>23.05.2019</td>
                  <td class="d-none d-md-table-cell">Граффити</td>
                  <td class="d-none d-md-table-cell">13.05.2019</td>
                </tr>
              </tbody>
              <tbody v-else>
                <tr>
                  <td class="font-weight-bold text-center" colspan="5">Нет просроченных задач</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script type="text/babel">
export default {
  data () {
    return {
      'header': 'header',
      count: 1
    }
  },
//   components: {
//     BarChart
//   },
  methods: {
    taskDetails (id) {
      console.log(id)
    }
  }
}
</script>