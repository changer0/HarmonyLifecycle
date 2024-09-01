import { JSON } from '@kit.ArkTS';
import { logger } from './Logger';

/**
 * 自定义属性装饰器,用于收集当前 Component 中的生命周期事件
 *
 * @author zhanglulu
 * @date 2024/9/1 20:05
 * @param target 当前 UI 组件实例
 * @param propertyKey 开发人员自定义的方法名
 */
export function LifecycleEvent(target: any, propertyKey: string | any) {
  logger(`LifecycleEvent: ${propertyKey}`)
  // define a setter and getter for the property
  // 把 Lifecycle 的实例注入到 UI 控件所依附的类实例上
  let value: any;
  const getter = () => value;
  const setter = function (newValue: any) {
    value = newValue;
    logger(`set ${propertyKey} to ${JSON.stringify(newValue)}`)
  };
  Object.defineProperty(target, propertyKey, {
    get: getter,
    set: setter,
    enumerable: true,
    configurable: true,
  });
  if (!target.rerender) {
    logger(`LifecycleEvent: ${propertyKey} !target.rerender, 渲染层没有准备好?`)
    return;
  }
  // 把 aboutToAppear 事件注入到 UI 控件所依附的类实例上
  handleAboutToAppear(target, propertyKey);
  // 把 onPageShow 事件注入到 UI 控件所依附的类实例上
  handleOnPageShow(target, propertyKey);
  // 把 onPageHide 事件注入到 UI 控件所依附的类实例上
  handleOnPageHide(target, propertyKey);
  // 把 aboutToDisappear 事件注入到 UI 控件所依附的类实例上
  handleAboutToDisappear(target, propertyKey);
  // 把 onBackPress 事件注入到 UI 控件所依附的类实例上
  handleOnBackPress(target, propertyKey);
}

/**
 * 处理 onBackPress 事件
 * @param target
 * @param propertyKey
 */
function handleOnBackPress(target: any, propertyKey: any) {
  if (target.onBackPress) {
    // UI 控件有自行实现的 onBackPress 事件
    let oldFunction = target.onBackPress;

    function backPress(): boolean | void {
      let oldRet = oldFunction.call(this);
      let ret = target[propertyKey].onBackPress();
      // 已经实现的方法和我们要监听的方法的返回值
      return oldRet || ret;
    }

    target.onBackPress = backPress;
  } else {
    // UI 控件没有自行实现的 onBackPress 事件
    target.onBackPress = () => {
      return target[propertyKey].onBackPress();
    };
  }
}

/**
 * 处理 aboutToDisappear 事件
 * @param target
 * @param propertyKey
 */
function handleAboutToDisappear(target: any, propertyKey: any) {
  if (target.aboutToDisappear) {
    // UI 控件有自行实现的 aboutToDisappear 事件
    let oldFunction = target.aboutToDisappear;

    function disappear() {
      target[propertyKey].aboutToDisappear();
      target[propertyKey].release();
      //TODO: 这块为什么要这么样调用???
      oldFunction.call(disappear.prototype.caller);
    }

    target.aboutToDisappear = disappear;
  } else {
    // UI 控件没有自行实现的 aboutToDisappear 事件
    target.aboutToDisappear = () => {
      target[propertyKey].aboutToDisappear();
      target[propertyKey].release();
    };
  }
}

/**
 * 处理 onPageHide 事件
 * @param target
 * @param propertyKey
 */
function handleOnPageHide(target: any, propertyKey: any) {
  if (target.onPageHide) {
    let oldFunction = target.onPageHide;

    // UI 控件有自行实现的 onPageHide 事件
    function pageHide() {
      target[propertyKey].onPageHide();
      oldFunction.call(this);
    }

    target.onPageHide = pageHide;
  } else {
    // UI 控件没有自行实现的 onPageHide 事件
    target.onPageHide = () => {
      target[propertyKey].onPageHide();
    };
  }
}

/**
 * 处理 onPageShow 事件
 * @param target
 * @param propertyKey
 */
function handleOnPageShow(target: any, propertyKey: any) {
  if (target.onPageShow) {
    // UI 控件有自行实现的 onPageShow 事件
    let oldFunction = target.onPageShow;

    function pageShow() {
      target[propertyKey].onPageShow();
      oldFunction.call(this);
    }

    target.onPageShow = pageShow;
  } else {
    // UI 控件没有自行实现的 onPageShow 事件
    target.onPageShow = () => {
      target[propertyKey].onPageShow();
    };
  }
}

/**
 * 处理 aboutToAppear 事件
 * @param target
 * @param propertyKey
 */
function handleAboutToAppear(target: any, propertyKey: any) {
  if (target.aboutToAppear) {
    // UI 控件有自行实现的 aboutToAppear 事件
    let oldFunction = target.aboutToAppear;

    function appear() {
      oldFunction.call(this);
      target[propertyKey].aboutToAppear();
    }

    target.aboutToAppear = appear;
  } else {
    // UI 控件没有自行实现的 aboutToAppear 事件
    target.aboutToAppear = () => {
      target[propertyKey].aboutToAppear();
    };
  }
}
