# Test Coverage & Test Cases Design
## Application: Minimal-Todo (Android)
**Repository:** [https://github.com/avjinder/Minimal-Todo](https://github.com/avjinder/Minimal-Todo)  
**Testing Framework:** Robot Framework + AppiumLibrary (UiAutomator2)  
**Document Version:** 1.0.0  

---

## 1. Test Coverage Overview

Minimal-Todo เป็นแอปพลิเคชัน Android สำหรับจัดการรายการสิ่งที่ต้องทำ (To-Do List) แบบเรียบง่าย โดยมีขอบเขตการทำงานหลัก (Functional Scope) ดังนี้:

```
Minimal-Todo Features
├── 1. Task Management
│   ├── Create Task (Title, Description, FAB button)
│   ├── View Tasks (RecyclerView list, Empty state)
│   ├── Edit Task (Update title, description, reminder)
│   └── Delete Task (Swipe to dismiss, Undo via Snackbar)
├── 2. Input Validation
│   ├── Title Character Limit (Max 30 characters)
│   └── Blank/Empty Title Handling
├── 3. Reminder & Notification
│   ├── Toggle Reminder Switch
│   └── Date & Time Picker
├── 4. Persistence & Lifecycle
│   ├── Data Persistence on App Relaunch / Restart
│   └── Device Rotation / State Handling
└── 5. Settings & Theme
    ├── Light / Dark (Night) Theme Switch
    └── About Screen
```

---

## 2. Test Cases Specification

| Test Case ID | Module / Feature | Priority | Test Scenario | Pre-condition | Test Steps | Test Data | Expected Result | Automation Status |
| :--- | :--- | :---: | :--- | :--- | :--- | :--- | :--- | :---: |
| **TC-MOB-001** | App Launch | P0 | ตรวจสอบหน้าจอเริ่มต้นเมื่อยังไม่มี Task | ติดตั้งแอปพลิเคชันใหม่ / ล้างข้อมูลแอป | 1. เปิดแอปพลิเคชัน Minimal-Todo<br>2. ตรวจสอบองค์ประกอบบนหน้าหลัก | - | 1. แสดง Empty View ("You have no things to do!")<br>2. แสดงปุ่ม Add Task FAB (+) ชัดเจน | Automated |
| **TC-MOB-002** | Add Task | P0 | สร้าง ToDo ใหม่พร้อมระบุ Title และ Description | แอปเปิดอยู่ที่หน้าหลัก | 1. กดปุ่ม Add Task FAB (+)<br>2. กรอก Title ในช่อง User ToDo<br>3. กรอก Description<br>4. กดปุ่ม Save FAB | Title: `Buy groceries`<br>Description: `Milk, Eggs, Bread` | 1. บันทึกสำเร็จ กลับสู่หน้าหลัก<br>2. รายการใหม่แสดงชื่อและรายละเอียดใน RecyclerView | Automated |
| **TC-MOB-003** | Edit Task | P0 | แก้ไขชื่อ ToDo เดิมที่มีอยู่แล้ว | มีรายการ ToDo อย่างน้อย 1 รายการ | 1. แตะที่รายการ ToDo ที่ต้องการแก้ไข<br>2. ลบชื่อเดิมและพิมพ์ชื่อใหม่<br>3. กดปุ่ม Save FAB | New Title: `Updated Task Name` | 1. กลับมาที่หน้ารายการหลัก<br>2. ชื่อ ToDo เปลี่ยนเป็นชื่อใหม่<br>3. ชื่อเดิมไม่แสดงในรายการ | Automated |
| **TC-MOB-004** | Delete Task | P0 | ลบ ToDo โดยการ Swipe (ปัดหน้าจอ) | มีรายการ ToDo ในรายการ | 1. ทำการ Swipe รายการ ToDo จากขวาไปซ้าย (หรือซ้ายไปขวา) | Target ToDo Item | 1. รายการ ToDo หายไปจากหน้าจอ<br>2. แสดง Snackbar แจ้งเตือนการลบพร้อมปุ่ม Undo | Automated |
| **TC-MOB-005** | Undo Delete | P1 | กู้คืน ToDo ที่ถูกลบด้วยปุ่ม Undo บน Snackbar | ทำการลบรายการ ToDo จนแสดง Snackbar | 1. Swipe ลบรายการ ToDo<br>2. รอ Snackbar ปรากฏ<br>3. กดปุ่ม `UNDO` บน Snackbar ภายในระยะเวลาที่กำหนด | Deleted ToDo Item | 1. รายการ ToDo กลับมาแสดงในตำแหน่งเดิม<br>2. ข้อมูลไม่สูญหาย | Automated |
| **TC-MOB-006** | Validation | P1 | ตรวจสอบการจำกัดความยาวของ Title ไม่เกิน 30 ตัวอักษร | แอปเปิดอยู่ที่หน้า Add Task | 1. กดปุ่ม Add Task FAB (+)<br>2. พิมพ์ข้อความยาวเกิน 30 ตัวอักษรลงในช่อง Title | Text: `ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890` (36 chars) | ข้อความในช่อง Title ถูกตัด/อนุญาตให้พิมพ์ได้สูงสุด 30 ตัวอักษร (`ABCDEFGHIJKLMNOPQRSTUVWXYZ1234`) | Automated |
| **TC-MOB-007** | Validation | P1 | ตรวจสอบการบันทึกโดยไม่กรอก Title (Empty Title) | แอปเปิดอยู่ที่หน้า Add Task | 1. กดปุ่ม Add Task FAB (+)<br>2. ปล่อยช่อง Title ว่างไว้<br>3. พยายามกดปุ่ม Save FAB | Title: ` ` (Empty) | ไม่สามารถบันทึกได้ / แอปแสดงข้อความแจ้งเตือนให้ใส่ข้อความ และไม่สร้าง ToDo ว่าง | Designed |
| **TC-MOB-008** | Reminder | P1 | สลับเปิด/ปิดสวิตช์ Remind Me | แอปเปิดอยู่ที่หน้า Add Task | 1. กดปุ่ม Add Task FAB (+)<br>2. ตรวจสอบสถานะสวิตช์ Remind Me<br>3. แตะสวิตช์เพื่อเปลี่ยนสถานะ | Remind Switch | สถานะของสวิตช์เปลี่ยนเป็น Checked/Unchecked และแสดงตัวเลือก Date/Time | Automated |
| **TC-MOB-009** | Reminder Date/Time | P1 | กำหนดวันที่และเวลาแจ้งเตือนล่วงหน้า | เปิดสวิตช์ Remind Me เรียบร้อยแล้ว | 1. แตะที่ Date Picker แล้วเลือกวันที่ในอนาคต<br>2. แตะ Time Picker แล้วเลือกเวลา<br>3. บันทึก ToDo | Date: Tomorrow<br>Time: 10:00 AM | วันที่และเวลาที่เลือกแสดงอยู่ใต้ชื่อ ToDo ในหน้าหลัก | Designed |
| **TC-MOB-010** | Persistence | P0 | ตรวจสอบความคงอยู่ของข้อมูลหลังปิดและเปิดแอปใหม่ | มีรายการ ToDo ที่บันทึกไว้ในแอป | 1. สร้าง ToDo รายการใหม่<br>2. สั่งปิดแอปพลิเคชัน (Kill/Close App)<br>3. เปิดแอปพลิเคชันขึ้นมาใหม่ | Persisted Item | รายการ ToDo ที่เคยสร้างไว้ยังคงแสดงครบถ้วน ไม่สูญหาย | Automated |
| **TC-MOB-011** | Settings / Theme | P2 | เปลี่ยน Theme เป็น Dark / Light Mode | อยู่ที่หน้าหลักของแอป | 1. กดปุ่มเมนู 3 จุด (More Options)<br>2. เลือก Settings<br>3. สลับเปิด/ปิด Night Mode | Theme Setting | สีของธีมหน้าจอเปลี่ยนเป็น Dark หรือ Light ตามที่เลือกทันที | Designed |

---

## 3. Automation Strategy & Execution Requirements

- **Platform:** Android 6.0+ (API 23+)
- **Package Name:** `com.avjindersinghsekhon.minimaltodo`
- **Main Activity:** `com.example.avjindersinghsekhon.minimaltodo.Main.MainActivity`
- **Automation Engine:** Appium UiAutomator2
- **Test Runner:** Robot Framework
- **Page Object / Keyword Pattern:** แยก Layers ชัดเจนระหว่าง Variables, Locators, Business Keywords และ Test Cases
