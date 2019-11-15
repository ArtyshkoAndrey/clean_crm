<template>
  <div class="main-content">
    <div class="row">
      <div class="col-12">
        <div class="card-body">
					<div class="row">
            <div class="col-12 mt-4">
							<h6>ФИО пользователя: <strong>{{user.name}}</strong></h6>
            </div>
            <div class="col-12 mt-2">
							<h6 class="pb-0 mb-0">Email:</h6>
							<p class="mt-0 pt-0 lead">{{user.email}}</p>
            </div>
            <div class="col-12 mt-2">
							<h6 class="pb-0 mb-0">Дата рождения</h6>
							<p class="mt-0 pt-0 lead">{{user.birthday}}</p>
            </div>
            <div class="col-12 mt-2">
							<h6 class="pb-0 mb-0">Роль (уровень доступа)</h6>
							<p class="mt-0 pt-0 lead">{{user.role}}</p>
            </div>
            <div class="col-12 mt-2">
							<h6 class="pb-0 mb-0">Отдел</h6>
							<p class="mt-0 pt-0 lead">{{user.department}}</p>
            </div>
					</div>
        </div>
			</div>
    </div>
  </div>
</template>