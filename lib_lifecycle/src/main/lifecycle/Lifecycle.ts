import { ArrayList } from '@kit.ArkTS';
import { ILifecycleObserver } from './ILifecycleEvent';

/**
 * 生命周期包装类
 * @author zhanglulu
 * @date 2024/9/1 20:05
 * @description
 */
export class Lifecycle {
  private mObserverList: ArrayList<ILifecycleObserver> | null = new ArrayList();

  /**
   * @Component
   * 组件即将出现时回调该接口，具体时机为在创建自定义组件的新实例后，在执行其build()函数之前执行。
   */
  aboutToAppear() {
    this.mObserverList?.forEach((observer) => {
      observer.aboutToAppear()
    })
  }

  /**
   * @Entry
   * 页面每次显示时触发一次，包括路由过程、应用进入前台等场景。
   */
  onPageShow() {
    this.mObserverList?.forEach((observer) => {
      observer.onPageShow()
    })
  }

  /**
   * @Entry
   * 页面每次隐藏时触发一次，包括路由过程、应用进入后台等场景。
   */
  onPageHide() {
    this.mObserverList?.forEach((observer) => {
      observer.onPageHide()
    })
  }

  /**
   * @Component
   * aboutToDisappear函数在自定义组件析构销毁之前执行
   */
  aboutToDisappear() {
    this.mObserverList?.forEach((observer) => {
      observer.aboutToDisappear()
    })
  }

  /**
   * @Entry
   * 返回true表示页面自己处理返回逻辑，不进行页面路由；
   * 返回false表示使用默认的路由返回逻辑，不设置返回值按照false处理
   * @returns
   */
  onBackPress(): boolean | void {
    let ret = false;
    this.mObserverList?.forEach((observer) => {
      //只要有一个观察者要处理,就不再让系统处理
      ret = ret || observer.onBackPress()
    })
    return ret;
  }


  /**
   * 添加观察者
   * @param callback
   */
  addObserver(observer: ILifecycleObserver) {
    this.mObserverList?.add(observer);
  }



  /**
   * 移除观察者
   * @param callback
   */
  removeObserver(observer: ILifecycleObserver) {
    this.mObserverList?.remove(observer);
  }

  /**
   * 释放所有观察者
   */
  release() {
    this.mObserverList?.clear();
    this.mObserverList = null;
  }
}
