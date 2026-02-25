# WordPress Farsi Auto Installer 🚀

نصب خودکار وردپرس فارسی روی Ubuntu Server

## 📦 شامل نصب:

- Nginx
- MariaDB
- PHP-FPM
- WordPress فارسی
- تنظیم خودکار nginx

---

## 🖥 سیستم مورد نیاز

- Ubuntu 20.04 یا 22.04
- حداقل 1GB RAM (پیشنهادی: 2GB)
- دامنه متصل به IP سرور

---

## 🚀 نحوه استفاده

روی سرور اجرا کنید:

```bash
apt install git -y
git clone https://github.com/Farzadmahmoudi/wordpress-installer.git
cd wordpress-installer
chmod +x install.sh
sudo ./install.sh


---

## 🗄 اطلاعات دیتابیس پیشفرض

- **Database:** `wp`
- **Username:** `wpuser`
- **Password:** `123456789`

> ⚠ پیشنهاد می‌شود پس از نصب، رمز دیتابیس را تغییر دهید.

---

## 🔐 فعال‌سازی SSL (اختیاری)

برای فعال کردن HTTPS رایگان (Let's Encrypt) دستورات زیر را اجرا کنید:

```bash
apt install certbot python3-certbot-nginx -y
certbot --nginx -d yourdomain.com











