import { Lifecycle, LifecycleEvent } from 'lib_lifecycle';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  @LifecycleEvent lifecycle: Lifecycle = new Lifecycle()
  aboutToAppear(): void {
    logger('old aboutToAppear called')
    this.lifecycle.addObserver({
      aboutToAppear: () => {
        logger('aboutToAppear called')
      },
      onPageShow: () => {
        logger('onPageShow called')
      },
      onPageHide: () => {
        logger('onPageHide called')
      },
      aboutToDisappear: () => {
        logger('aboutToDisappear called')
      },
      onBackPress: () => {
        logger('onBackPress called')
        return false
      },
    })
  }




  /**
   * 返回true表示页面自己处理返回逻辑，不进行页面路由；返回false表示使用默认的路由返回逻辑，不设置返回值按照false处理
   * @returns
   */
  onBackPress(): boolean | void {
    logger('old onBackPress called')
    return false
  }

  onPageShow(): void {
    logger('old onPageShow called')
  }

  onPageHide(): void {
    logger('old onPageHide called')
  }

  aboutToDisappear(): void {
    logger('old aboutToDisappear called')
  }


  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }


}

function logger(msg: string) {
  console.log(`[LIFECYLE][ZLL] ${msg}`);
}

