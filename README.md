# RampageMVVC

MVVC โดย Swift สำหรับ iOS
จุดเด่นคือใช้ไฟล์ .xib เพื่อสร้าง interface แทนที่จะเป็น Storyboard 
เพราะการทำงาน แยกส่วนเป็น Module ทำได้ดีกว่า 
และยังง่ายต่อการ ทำงานเป็นทีมด้วย Git ที่จะเกิดความยาก เมื่อทำงานหลายคน บนไฟล์ storyboard เพียงไฟล์เดียว

RampageMVVC ได้ถูกออกแบบ ให้เป็นลักษณะ Modular สามารถถอดประกอบหน้าแต่ละหน้าได้
การสร้าง interface ด้วย xib จึงง่ายต่อการ เพิ่มหรือลบ หน้าแต่ละหน้าของแอพ

# ก่อนเริ่มต้น
## ติดตั้ง เทมเพล็ตสำหรับ xCode
ดาวน์โหลด หรือโคลน repositoty คุณจะพบโฟลเดอร์ xcode templates 
จะมีสคริป เพื่อติดตั้ง เทมเพล็ต สำหรับ iOS คือ `install.sh`
และสคริปสำหรับลบเทมเพล็ตคือ `uninstall.sh` สามารถรันคำสั่งนี้ บน Terminal

## หรือเพื่อความรวดเร็ว ให้ Copy คำสั่งนี้ รันบน Terminal
install command
```
git clone git@github.com:heart/RampageMVVM-iOS-Swift.git
cd "RampageMVVM-iOS-Swift/xcode templates"
./install.sh
cd ..
rm -rf RampageMVVM-iOS-Swift
```

## สำสั่งสำหรับลบ template 
uninstall command
```
git clone git@github.com:heart/RampageMVVM-iOS-Swift.git
cd "RampageMVVM-iOS-Swift/xcode templates"
./uninstall.sh
cd ..
rm -rf RampageMVVM-iOS-Swift
```

# เริ่มต้นง่ายๆ ด้วยโปรเจคใหม่

### สร้าง Project xCode ใหม่ เลือก Single View App เลือกเป็นภาษา Swift และ Storyboard
![New Project](https://raw.githubusercontent.com/heart/RampageMVVM-iOS-Swift/master/images/newproject.png)

### ติดตั้ง RampageMVVC Package
1. ที่โปรเจคของคุณใน xCode ไปที่เมนู File > Swift Package > Add Package Deepndency
1. ในช่อง URL ใส่ https://github.com/heart/RampageMVVM-iOS-Swift
1. เลือก Branch Master (ใช้ master ก่อนในระหว่างพัฒนา)

### สร้าง Group ขึ้นมาใหม่ โดยที่ Group นี้จะหมายถึง หน้าแอพ 1 หน้า ไฟล์ทั้งหมดที่เกี่ยวข้อง จะเก็บอยู่ที่นี่ ยกตัวอย่างเช่น สร้าง Group ชื่อ Home
![New Group](https://raw.githubusercontent.com/heart/RampageMVVM-iOS-Swift/master/images/homegroup.png)

### คลิกเลือก Group Home สร้างไฟล์ใหม่ กด `Command + N`
![New Group](https://raw.githubusercontent.com/heart/RampageMVVM-iOS-Swift/master/images/newfile.png)
เมื่อติดตั้ง Template แล้ว ท่านจะมี Template ชื่อ RPMVVM

กด Next และตั้งช่ือ Module Name ว่า Home แล้วกด Next 

จะได้ไฟล์ทั้งหมด 7 ไฟล์ดังภาพนี้
![New Group](https://raw.githubusercontent.com/heart/RampageMVVM-iOS-Swift/master/images/home.png)

# Xcode 11 กับ SceneDelegate
ใน xCode 11 หลังจากการมี Swift UI เมื่อสร้างโปรเจคใหม่ เราจะมีคลาสเพิ่มขึ้นมา ชื่อว่า SceneDelegate
เราจะเปลี่ยนให้ เรียก HomeViewController ขึ้นมาแสดง แทนที่จะโหลด Storyboard ได้ โดยการแก้ไขโค้ดของ SceneDelegate.swift

## แก้ไข SceneDelegate.swift ที่ฟังชั่น scene:willConnectTo ดังนี้
```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let home = HomeViewController()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = home
        window?.makeKeyAndVisible()
    }
```


## อธิบายโครงสร้าง การทำงาน

![New Group](https://raw.githubusercontent.com/heart/RampageMVVM-iOS-Swift/master/images/structure.png)

### HomeViewController.swift
HomeViewController จะ สืบทอดมาจากคลาส RPViewController
เมื่อเริ่มทำงาน มันจะมองหาไฟล์ XIB ที่มีชื่อเดียวกับคลาส และโหลดไฟล์นั้น ขึ้นมาเป็น UI interface ของหน้านี้ โดยอัตโนมัติ
HomeViewController จะเป็นผู้ประสานงาน ระหว่าง View และ ViewModel

### HomeViewController.xib
HomeViewController.xib เป็น UI ของ HomeViewController.swift ที่จะถูกโหลดขึ้นมาอัตโนมัติ

### HomeView.swift
View จะมีหน้าที่ ดูแล UI เท่านั้น และทำงานกับการ interfactive ของ User 
เมื่อ User ต้องการอะไร ก็จะทำการส่ง Event ด้วยคำสั่ง dispatch ไปยัง HomeViewController ให้รับหน้าที่ต่อ

ตัวอย่างการ dispatch 
```swift
@IBAction func clickLogin(_ sender: Any) {
    let data = ["message": "Hello, World!"]
    let event = RPEvent(name: "sendMessage", data: data)
    dispatch(event: event)
}
```
View ควรทำงาน ด้วยตัวเองได้โดยสมบูรณ์ จนกว่าจะต้องการ เรียกข้อมูลเพิ่ม จึง dispatch ออกไป
ทุกๆการ dispatch ช่วยให้เราทราบว่า View นี้ มี input จาก User ทั้งหมด กี่ครั้ง อะไรบ้าง

### HomeViewModel.swift
ViewModel เป็นคลาสที่จะจัดการข้อมูลที่ส่งออกไป และนำข้อมูลกลับมาแสดงผล บนหน้า View
โดยทีี่ ViewModel จะช่วยให้เราทราบว่า มีงานที่ต้องเรียกข้อมูลออกไป กี่ประเภทบ้าง

Rampage ได้ออกแบบให้ ใน HomeService.swift ต้องเรียก API เป็น Synchronous เสมอเพื่อให้ ViewModel สะดวกต่อการ
เรียก API หลายตัวประกอบกันได้ ในลักษณะ Async Await ในภาษาอื่น

โดยที่ ViewModel จะใช้ RP.async เพื่อ ให้การเรียก Service ทำงานบน Background Mode 
และประกอบข้อมูลเข้าด้วยกัน ให้ง่ายต่อการนใช้งาน
และเมื่อทำงานจบ ก็จะเรียกใช้ RP.main เพื่อโยนการทำงานและข้อมูล กลับไปทำงานบน Thread หลัก

### HomeServices.swift 
มีหน้าที่ ติดต่อไปยัง Web Service ใดๆ เช่น Rest API 
และจะเป็นคลาสที่ ทำงานกับ JSON เมื่อได้รับ Response แล้ว ให้ทำการแปลง JSON ให้เป็น Model ที่นี่
และ Return กลับไปให้ ViewModel

### HomeModel.swift
เป็น Model ที่จะถือข้อมูล ของ API ที่ถูกเรียกใช้งาน



