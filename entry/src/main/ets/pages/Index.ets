import { Lifecycle, LifecycleEvent } from 'lib_lifecycle';
import { LiveData } from 'lib_livedata';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @LifecycleEvent lifecycle: Lifecycle = new Lifecycle()

  /**
   * 订阅数据变化 示例
   */
  indexLivedata: LiveData<string> = new LiveData<string>();

  aboutToAppear(): void {
    // logger('old aboutToAppear called')
    this.indexLivedata.setValue(`这是旧的值: ${Math.random()*100}`)
    this.indexLivedata.observe(this.lifecycle, (value: string) => {
      logger(`new value: ${value}`)
    })


    this.lifecycle.addObserver({
      aboutToAppear: () => {
        logger(`aboutToAppear called !!!!`)
      },
      onPageHide: () => {
        logger(`onPageHide called !!!!`)
      },
      onPageShow: () => {
        logger(`onPageShow called !!!!`)
      },
      onBackPress: (): boolean => {
        logger(`onBackPressed called !!!!`)
        return false;
      },
      aboutToDisappear: () => {
        logger(`aboutToDisappear called !!!!`)
      }
    })
  }

  aboutToDisappear(): void {
    // logger('old aboutToDisappear called')
  }

  build() {
    Column() {
      Text("Index页面")
      Button("修改indexLivedata")
        .margin({ top: 20})
        .onClick((event) => {
          this.indexLivedata.setValue(`indexLivedata 设置新的数据: ${Math.random()*100}`)
        })
      Button("跳转新页面")
        .margin({ top: 20})
        .onClick((event) => {
          logger("跳转 NewPage")
          router.pushUrl({
            url: "pages/NewPage"
          })
        })
    }
    .height('100%')
    .width('100%')
  }
}

function logger(msg: string) {
  console.log(`[ZLL][PAGE][Index] ${msg}`);
}

