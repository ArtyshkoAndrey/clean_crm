'use strict'
export default class Task {
  constructor (task) {
    for (let key in task) {
      let CamelCaseKey = key.replace(/[-_]([a-z])/g,
        (m) => {
          return m[1].toUpperCase()
        }
      )
      this[CamelCaseKey] = task[key]
      if (CamelCaseKey === 'street') {
        this[CamelCaseKey] = {}
        this[CamelCaseKey]['value'] = task[key]
      }
      if (CamelCaseKey.includes('Date')) {
        if (this[CamelCaseKey]) {
          this[CamelCaseKey] = new Date(this[CamelCaseKey].slice(6, 10), parseInt(this[CamelCaseKey].slice(3, 5)) - 1, this[CamelCaseKey].slice(0, 2))
        }
        Object.defineProperty(this, '_' + CamelCaseKey + 'String', {
          get: function () {
            if (this[CamelCaseKey]) {
              // return this[CamelCaseKey].getFullYear() + '-' + this[CamelCaseKey].getMonth() + '-' + this[CamelCaseKey].getDate()
              // return this[CamelCaseKey].toJSON().substr(0, 10)
              this[CamelCaseKey].setHours(20)
              return this[CamelCaseKey].toJSON().substr(0, 10)
            } else {
              return ''
            }
          }
        })
      }
    }
  }

  toJSON () {
    const jsonObj = Object.assign({}, this)
    for (const key of Object.getOwnPropertyNames(this)) {
      const desc = Object.getOwnPropertyDescriptor(this, key)
      const hasGetter = desc && typeof desc.get === 'function'
      if (hasGetter) {
        jsonObj[key] = this[key]
      }
    }
    return jsonObj
  }
}
