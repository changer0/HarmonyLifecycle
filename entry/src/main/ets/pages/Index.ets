import { Lifecycle, LifecycleEvent } from 'lib_lifecycle';
import { LiveData } from 'lib_livedata';

@Entry
@Component
struct Index {
  @LifecycleEvent lifecycle: Lifecycle = new Lifecycle()

  /**
   * 订阅数据变化 示例
   */
  helloLivedata: LiveData<string> = new LiveData<string>();

  aboutToAppear(): void {
    logger('old aboutToAppear called')
    this.helloLivedata.setValue(`这是旧的值: ${Math.random()*100}`)
    this.helloLivedata.observe(this.lifecycle, (value: string) => {
      logger(`new value: ${value}`)
    })

    this.lifecycle.addObserver({
      onPageHide: () => {
        logger(`onPageHide called !!!!`)
      },
      onPageShow: () => {
        logger(`onPageShow called !!!!`)
      },
      onBackPress: (): boolean => {
        logger(`onBackPressed called !!!!`)
        return true;
      }
    })
  }

  aboutToDisappear(): void {
    logger('old aboutToDisappear called')
  }

  build() {
    RelativeContainer() {
      Text("验证 LiveData")
        .id('_id_text')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center:{ anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick((event) => {
          this.helloLivedata.setValue(`这是新的值: ${Math.random()*100}`)
        })
    }
    .height('100%')
    .width('100%')
  }
}

function logger(msg: string) {
  console.log(`[LIFECYLE][ZLL] ${msg}`);
}

