import { Lifecycle } from 'lib_lifecycle';

type Observer<T> = (value: T) => void;

/**
 * @author zhanglulu
 * @description LiveData 用于持有可被观察的数据,
 */
export class LiveData<T> {
  private _value: T | undefined;
  // 观察者集合
  private observers: Set<Observer<T>>;

  constructor() {
    this.observers = new Set();

  }

  /**
   * 订阅数据变化
   * @param lifecycle 生命周期
   * @param observer 观察者函数
   * @param sticky 是否为粘性订阅，默认为 true
   */
  observe(lifecycle: Lifecycle, observer: Observer<T>, sticky: boolean = true): void {
    this.observers.add(observer);
    if (sticky && this._value !== undefined) {
      observer(this._value);
    }
    let that = this;
    lifecycle.addObserver({
      aboutToDisappear: () => {
        // 移除观察者
        that.removeObserver(observer);
      }
    })
  }


  /**
   * 订阅数据变化, 不需要生命周期管理
   * @param lifecycle 生命周期
   * @param observer 观察者函数
   * @param sticky 是否为粘性订阅，默认为 true
   */
  observeForever(observer: Observer<T>, sticky: boolean = true): void {
    this.observers.add(observer);
    if (sticky && this._value !== undefined) {
      observer(this._value);
    }
  }

  /**
   * 移除观察者
   * @param observer 要移除的观察者函数
   */
  removeObserver(observer: Observer<T>): void {
    this.observers.delete(observer);
  }

  /**
   * 设置新值，并通知所有观察者
   * @param value 新的值
   */
  setValue(value: T): void {
    this._value = value;
    this.notifyObservers(value);
  }

  /**
   * 获取当前值
   * @returns 当前持有的值
   */
  getValue(): T | undefined {
    return this._value;
  }

  /**
   * 通知所有观察者
   * @param value 要通知的值
   */
  private notifyObservers(value: T): void {
    this.observers.forEach((observer) => {
      observer(value);
    });
  }
}