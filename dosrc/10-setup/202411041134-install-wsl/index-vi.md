## Windows Subsystem for Linux (WSL) là gì?

[Windows Subsystem for Linux (WSL)](https://learn.microsoft.com/en-us/windows/wsl/about) là tính năng của Windows cho phép bạn chạy một môi trường Linux trên máy tính Windows của mình, mà không cần cài đặt một máy ảo riêng biệt hoặc dùng phương pháp khởi động kép.

Hình bên dưới minh hoạ 1 phiên bản Ubuntu Linux chạy bên trong Windows thông qua WSL:

```bs-cards equals=true cols=1 lightbox=wsl
    [[bs-card
    -img:wsl01.jpg
    -subtitle:Ubuntu Linux chạy trên Windows thông qua WSL
    ]]
```

## Cài đặt WSL

Tài liệu hướng dẫn chi tiết cách cài đặt WSL có thể được tìm thấy tại [đây](https://learn.microsoft.com/en-us/windows/wsl/install). Bài viết này sẽ tóm tắt các bước chính để cài đặt WSL trên Windows.

> Phiên bản hiện tại của WSL là WSL 2. Khi bạn cài đặt mới, phiên bản WSL 2 sẽ được cài đặt mặc định.

**Yêu cầu:** Máy tính của bạn cần chạy Windows 11, hoặc Windows 10 phiên bản 2004 hoặc cao hơn (build 19041 trở về sau).

**Cài đặt WSL:**

Mở cửa sổ Command Prompt hoặc PowerShell với quyền quản trị. Hình minh hoạ dưới đây là cửa sổ PowerShell:

```bs-cards equals=true cols=2 lightbox=run-powershell
    [[bs-card
    -img:powershell-run-as-admin.jpg
    -subtitle:Chạy PowerShell với quyền quản trị
    ]]

    [[bs-card
    -img:powershell-run-as-admin-2.jpg
    -subtitle:Cửa sổ PowerShell với quyền quản trị
    ]]
```

Chạy lệnh `wsl --install` ở cửa sổ PowerShell hoặc cửa sổ Command Prompt để cài đặt WSL. Thời gian cài đặt có thể mất một vài phút, tuỳ vào tốc độ internet của bạn. Ubuntu Linux sẽ được cài đặt mặc định cùng với WSL:

```bs-cards equals=true cols=1 lightbox=wsl-install
    [[bs-card
    -img:wsl-install.jpg
    -subtitle:Cài đặt WSL từ lệnh wsl --install
    ]]
```

_Khởi động lại máy tính_ sau khi cài đặt xong. Sau khi khởi động máy, bạn có thể chạy Ubuntu trên Windows của bạn:

```bs-cards equals=true cols=2 lightbox=run-ubuntu
    [[bs-card
    -img:wsl-run-ubuntu.jpg
    -subtitle:Chạy Ubuntu Linux trên Windows sau khi cài đặt WSL
    ]]
```

**Cài đặt thêm các bản Linux khác:** Bản cài đặt mặc định của WSL là Ubuntu Linux. Bạn có thể sử dụng lệnh sau để xem danh sách các bản Linux khác có thể cài đặt:

```terminal
PS > wsl --list --online
The following is a list of valid distributions that can be installed.
Install using 'wsl.exe --install <Distro>'.

NAME                            FRIENDLY NAME
Ubuntu                          Ubuntu
Debian                          Debian GNU/Linux
kali-linux                      Kali Linux Rolling
Ubuntu-18.04                    Ubuntu 18.04 LTS
Ubuntu-20.04                    Ubuntu 20.04 LTS
Ubuntu-22.04                    Ubuntu 22.04 LTS
Ubuntu-24.04                    Ubuntu 24.04 LTS
OracleLinux_7_9                 Oracle Linux 7.9
OracleLinux_8_7                 Oracle Linux 8.7
OracleLinux_9_1                 Oracle Linux 9.1
openSUSE-Leap-15.6              openSUSE Leap 15.6
SUSE-Linux-Enterprise-15-SP5    SUSE Linux Enterprise 15 SP5
SUSE-Linux-Enterprise-15-SP6    SUSE Linux Enterprise 15 SP6
openSUSE-Tumbleweed             openSUSE Tumbleweed
```

Để cài đặt một bản Linux khác, bạn có thể sử dụng lệnh `wsl --install -d <tên-bản-linux>`, ví dụ:

```terminal
PS > wsl --install -d kali-linux
Installing: Kali Linux Rolling
Kali Linux Rolling has been installed.
```

## Lỗi Virtual Machine Platform Windows (0x80370102)

Nếu bạn gặp lỗi tương tự như sau khi cài đặt WSL:

```terminal
WslRegisterDistribution failed with error: 0x80370102
Please enable the Virtual Machine Platform Windows feature and ensure virtualization is enabled in the BIOS.
For information please visit https://aka.ms/enablevirtualization
Press any key to continue...
```

Xem cách xử lý tại website hướng dẫn của Microsoft: [https://aka.ms/enablevirtualization](https://aka.ms/enablevirtualization).

<hr>

_[[do-tag ghissue_comment]]_
