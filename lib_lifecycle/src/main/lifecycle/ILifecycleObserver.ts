/**
 * 生命周期观察者
 */
export declare interface ILifecycleObserver {
  /**
   * @Component
   * 组件即将出现时回调该接口，具体时机为在创建自定义组件的新实例后，在执行其build()函数之前执行。
   */
  aboutToAppear(): void

  /**
   * @Entry
   * 页面每次显示时触发一次，包括路由过程、应用进入前台等场景。
   */
  onPageShow(): void

  /**
   * @Entry
   * 页面每次隐藏时触发一次，包括路由过程、应用进入后台等场景。
   */
  onPageHide(): void

  /**
   * @Component
   * aboutToDisappear函数在自定义组件析构销毁之前执行
   */
  aboutToDisappear(): void

  /**
   * 当用户按下返回键时调用。
   * 返回true表示页面自己处理返回逻辑，不进行页面路由；
   * 返回false表示使用默认的路由返回逻辑，不设置返回值按照false处理
   */
  onBackPress(): boolean
}