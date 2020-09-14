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

กด Next และตั้งช่ื่อ Module Name ว่า Home แล้วกด Next 

จะได้ไฟล์ทั้งหมด 7 ไฟล์ดังภาพนี้
![New Group](https://raw.githubusercontent.com/heart/RampageMVVM-iOS-Swift/master/images/home.png)

RPViewController