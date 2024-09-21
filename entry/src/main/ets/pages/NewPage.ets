import { Lifecycle, LifecycleEvent } from 'lib_lifecycle';
import { LiveData } from 'lib_livedata';

@Entry
@Component
struct NewPage {
  // 生命周期
  @LifecycleEvent lifecycle: Lifecycle = new Lifecycle()
  /**
   * 订阅数据变化 示例
   */
  newPageLivedata: LiveData<string> = new LiveData<string>();

  aboutToAppear(): void {
    this.newPageLivedata.setValue("newPageLivedata 粘性数据测试")
    this.newPageLivedata.observe(this.lifecycle, (value: string) => {
      logger(`接收到新数据: ${value}`)
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

  build() {
    Column() {
      Text("NewPage页面")
      Button("修改newPageLivedata")
        .margin({ top: 20})
        .onClick((event) => {
          this.newPageLivedata.setValue(`newPageLivedata 设置新的数据: ${Math.random()*100}`)
        })
    }
    .height('100%')
    .width('100%')
  }
}

function logger(msg: string) {
  console.log(`[ZLL][PAGE][NewPage] ${msg}`);
}

