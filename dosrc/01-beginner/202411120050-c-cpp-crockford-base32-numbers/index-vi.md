```bs-alert info

[[do-tag tutorial_only]]
```

# Đề bài

```bs-alert primary

Viết chương trình C hoặc C++, chuyển 1 số thập phân (ví dụ `12345`) sang hệ cơ số 32 sử dụng bảng mã [Crockford Base32](/cms/others/crockford-base32/) (ví dụ `C1S`).
```

Bài tập này củng cố kiến thức về:
- Nhập, xuất.
- Tạo và sử dụng hàm.
- Vòng lặp và rẽ nhánh.

_Xem bài viết giới thiệu về hệ cơ số 32 và bảng mã Crockford Base32 tại đây: [Crockford Base32](/cms/others/crockford-base32/)._

Để đơn giản, chương trình chỉ xử lý các số _nguyên dương_. Giả định rằng dữ liệu nhập vào luôn đúng đinh dạng, không cần kiểm tra dữ liệu nhập vào.

# Hướng dẫn bài giải

```bs-alert secondary

[[do-tag playground_ccpp]]
```

### Nhập dữ liệu

Phần này đơn giản nên ta làm trước. Ta sẽ viết 2 hàm: 1 hàm nhập 1 số thập phân và 1 hàm nhập 1 số ở hệ cơ số 32 từ bàn phím.

```bs-tabs
    [[bs-tab main.c
    ```c
    #include <stdio.h>
    #include <stdlib.h>

    int nhapSoThapPhan() {
        int n;
        printf("Nhập số thập phân: ");
        scanf("%d", &n);
        return n;
    }

    char* nhapSoBase32() {
        char* s = (char*)malloc(100+1);
        printf("Nhập số ở hệ cơ số 32 (bảng mã Crockford Base32): ");
        scanf("%s", s);
        return s;
    }
    ```
    ]]

    [[bs-tab main.cpp
    ```cpp
    #include <iostream>

    int nhapSoThapPhan() {
        int n;
        std::cout << "Nhập số thập phân: ";
        std::cin >> n;
        return n;
    }

    std::string nhapSoBase32() {
        std::string s;
        std::cout << "Nhập số ở hệ cơ số 32 (bảng mã Crockford Base32): ";
        std::cin >> s;
        return s;
    }
    ```
    ]]
```

Trong C, ta dùng hàm `scanf` để nhập dữ liệu từ bàn phím. Hàm này nằm trong thư viện `stdio.h`, ta khai báo sử dụng thư viện này thông qua câu lệnh `#include <stdio.h>`.

- Tham số đầu tiên của hàm `scanf` là _định dạng_ cho kiểu dữ liệu mà bạn muốn nhập. Để nhập _số nguyên_ ta sử dụng định dạng `"%d"`; để nhập _chuỗi ký tự_ ta sử dụng định dạng `"%s"`. Xem thêm về các định dạng khác trong tài liệu chi tiết của hàm `scanf` tại đây: https://cplusplus.com/reference/cstdio/scanf/
- Tham só thứ 2 của hàm `scanf` là biến nơi chúng ta lưu giá trị nhập vào. Trong đoạn chương trình ở trên, ta nhập số nguyên vào biến `n` nên ta sử dụng lệnh `scanf("%d", &n);`, và ta nhập chuỗi ký tự vào biến `s` nên ta sử dụng lệnh `scanf("%s", s);`.
- Ký tự `&` ở trước tên biến `n` là để lấy địa chỉ của biến. `&n` biểu thị rằng "lưu nội dung vào địa chỉ này nè" (mà cái địa chỉ "này" đang trỏ đến biến `n`).
- Lưu ý: chuỗi trong C là 1 mảng các ký tự với biến là con trỏ đến kỹ tự đầu tiên. Do bản thân nó đã là con trỏ nên không cần phải sử dụng dấu `&` trước tên biến khi nhập chuỗi ký tự.
- Lưu ý: ta cần cấp phát bộ nhớ cho chuỗi ký tự `s` trước khi nhập dữ liệu. Ở đây ta cấp phát 100 ký tự + 1 ký tự `\0` kết thúc chuỗi thông qua lời gọi hàm `malloc(100+1)`. Hàm này nằm trong thư viện `stdlib.h`. Ta khai báo sử dụng thư viện này thông qua câu lệnh `#include <stdlib.h>`.

Với C++ thì cú pháp đơn giản hơn một tí, ta dùng `std::cin >> n;` để nhập giá trị số cho biến `n`, và dùng `std::cin >> s;` để nhập chuỗi ký tự cho biến `s`. Để ý rằng trong C++ ta không cần phải chỉ định rõ định dạng dữ liệu nhập vào, cũng như không cần phải sử dụng địa chỉ của biến. Các hàm nhập/xuất trong C++ nằm trong thư viện `iostream`, ta khai báo sử dụng thư viện này thông qua câu lệnh `#include <iostream>`.

### Chuyển đổi số thập phân sang hệ cơ số 32

Kế tiếp, ta viết 1 hàm chuyển đổi số thập phân sang hệ cơ số 32.

```bs-alert secondary

Xem bài viết giới thiệu về hệ cơ số 32 và bảng mã Crockford Base32 tại đây: [Crockford Base32](/cms/others/crockford-base32/). Lưu ý rằng bảng mã Crockford Base32 sử dụng 10 chữ số (0-9) và 22 chữ cái (bảng chữ cái tiếng Anh bỏ đi các ký tự I, L, O, U), tổng cộng 32 ký tự.
```

```bs-tabs
    [[bs-tab main.c
    ```c
    #include <stdlib.h>
    #include <string.h>

    // đảo ngược 1 chuỗi
    char* daoChuoi(char* str) {
        int n = strlen(str); // lấy độ dài của chuỗi
        for (int i = 0; i < n / 2; i++) {
            char temp = str[i];
            str[i] = str[n - i - 1];
            str[n - i - 1] = temp;
        }
        return str;
    }

    // đổi số thập phân sang cơ số 32
    char* doiSangBase32(int n) {
        char base32[] = "0123456789ABCDEFGHJKMNPQRSTVWXYZ";
        char* ketqua = (char*)malloc(16+1); // cấp phát tối đa 16 ký tự + ký tự \0 kết thúc

        // convert to base32
        int i = 0;
        while (n > 0) {
            ketqua[i++] = base32[n % 32];
            n /= 32;
        }
        ketqua[i] = '\0';
        return daoChuoi(ketqua);
    }
    ```
    ]]

    [[bs-tab main.cpp
    ```cpp
    #include <iostream>

    // đổi số thập phân sang cơ số 32
    std::string doiSangBase32(int n) {
        std::string base32 = "0123456789ABCDEFGHJKMNPQRSTVWXYZ";
        std::string s;
        while (n > 0) {
            s = base32[n % 32] + s;
            n /= 32;
        }
        return s;
    }
    ```
    ]]
```

Ở đây chúng ta áp dụng thuật toán đổi 1 số thập phân (ở hệ cơ số 10) sang một hệ cơ số khác (ở đây là hệ cơ số 32). Với 1 vài lưu ý:
- Bảng mã Crockford Base32 sử dụng bảng chữ cái tiếng Anh, nhưng loại bỏ số chữ ở giữa bảng chữ cái. Do vậy chúng ta cần phải tạo ra bảng mã mới mà không chứa các chữ cái bị loại bỏ.
- Trong cả 2 đoạn chương trình C và C++, ta sử dụng chung 1 thuật toán đổi số thập phân sang hệ cơ số 32. Nhưng cách xử lý chuỗi kết quả có chút khác biệt:
    - Trong C, chuỗi là 1 mảng các ký tự, với kiểu dữ liệu bên dưới là 1 con trỏ đến ký tự đầu tiên. Để tiện xử lý, mỗi khi chuyển 1 chữ số, ta nối tiếp vào chuỗi kết quả. Và cuối cùng ta đảo ngược chuỗi nhận được để ra két quả cuối cùng.
    - Ta cũng cần cấp phát bộ nhớ để lưu chuỗi kết quả. Ta giả sử rằng chuỗi kết quả có thể chứa tối đa 16 ký tự và thêm 1 ký tự `\0` kết thúc chuỗi. Ta gọi hàm `malloc(16+1)` để cấp phát tổng cộng 17 ký tự cho chuỗi kết quả.
    - Trong C++, kiểu `std::string` hỗ trợ toán tử `+` để nối chuỗi, tuỳ ý vào cuối hoặc đầu chuỗi. Do vậy với C++, mỗi khi chuyển 1 chữ số, ta nối chữ số đó vào đầu chuỗi kết quả, và không cần phải đảo ngược chuỗi nữa.

Các thư viện cần dùng:
- C: `#include <stdlib.h>` để sử dụng hàm `malloc`; thư viện `#include <string.h>` để sử dụng hàm `strlen`.
- C++: `#include <iostream>`.

### Chuyển đổi số ở hệ cơ số 32 sang thập phân

Ta xử lý nốt hàm chuyển đổi số ở hệ cơ số 32 sang hệ cơ số 10.

```bs-tabs
    [[bs-tab main.c
    ```c
    #include <ctype.h>

    // chuyển 1 ký tự sang số
    int charToNum(char c) {
        c = toupper(c); // chuyển thành ký tự in hoa
        switch (c) {
            // theo qui định của bảng mã Crockford, chấp nhận ký tự I và L, nhưng chuyển thành số 1
            case 'I': case 'L':
                c = '1';
                break;
            // theo qui định của bảng mã Crockford, chấp nhận ký tự O, nhưng chuyển thành số 0
            case 'O':
                c = '0';
                break;
            // theo qui định của bảng mã Crockford, chấp nhận ký tự U, nhưng chuyển thành V
            case 'U':
                c = 'V';
                break;
        }
        char base32[] = "0123456789ABCDEFGHJKMNPQRSTVWXYZ";
        for (int i = 0; i < 32; i++) {
            if (c == base32[i]) return i;
        }
        return -1;
    }

    // chuyển số ở hệ cơ số 32 sang thập phân
    int doiSangThapPhan(char* s) {
        int n = 0;
        for (int i = 0; s[i] != '\0'; i++) {
            int num = charToNum(s[i]);
            if (num == -1) return -1; // có ký tự không hợp lệ!
            n = n * 32 + num;
        }
        return n;
    }
    ```
    ]]

    [[bs-tab main.cpp
    ```cpp
    #include <iostream>

    // chuyển 1 ký tự sang số
    int charToNum(char c) {
        c = std::toupper(c); // chuyển thành ký tự in hoa
        switch (c) {
            // theo qui định của bảng mã Crockford, chấp nhận ký tự I và L, nhưng chuyển thành số 1
            case 'I': case 'L':
                c = '1';
                break;
            // theo qui định của bảng mã Crockford, chấp nhận ký tự O, nhưng chuyển thành số 0
            case 'O':
                c = '0';
                break;
            // theo qui định của bảng mã Crockford, chấp nhận ký tự U, nhưng chuyển thành V
            case 'U':
                c = 'V';
                break;
        }
        std::string base32 = "0123456789ABCDEFGHJKMNPQRSTVWXYZ";
        for (int i = 0; i < 32; i++) {
            if (c == base32[i]) return i;
        }
        return -1;
    }

    // chuyển số ở hệ cơ số 32 sang thập phân
    int doiSangThapPhan(std::string s) {
        int n = 0;
        for (int i = 0; i < s.length(); i++) {
            int num = charToNum(s[i]);
            if (num == -1) return -1; // có ký tự không hợp lệ!
            n = n * 32 + num;
        }
        return n;
    }
    ```
    ]]
```

Ta áp dụng cùng 1 thuật toán trong C và C++ để chuyển 1 số ở hệ cơ số 32 sang hệ cơ số 10. Chỉ khác nhau 1 tẹo về kiểu dữ liệu và các hàm thư viện. Với 1 vài lưu ý nhỏ:
- Dữ liệu nhập vào có thể bao gồm cả chữ hoa và chữ thường. Để chuẩn hoá, ta chuyển toàn bộ về chữ hoa.
- Crockford Base32 không dùng các  ký tự `I`, `L`, `O`, `U` khi chuyển từ số thập nhân sang base32. Nhưng vẫn chấp nhận các ký tự này khi chuyển từ base32 về thập phân với qui tắc:
  - `I` và `L` chuyển thành `1`.
  - `O` (ký tự O) chuyển thành `0` (số 0).
  - `U` chuyển thành `V`.

Các thư viện cần dùng:
- C: `#include <ctype.h>` để sử dụng hàm `toupper`.
- C++: `#include <iostream>`.

### Chương trình mẫu

Cuối cùng, ta có chương trình hoàn chỉnh:

```bs-tabs
    [[bs-tab main.c
    ```gh-gist btnguyen2k/30c84a22fbf296efb427826b3d72a2ff
    ```
    ]]

    [[bs-tab main.cpp
    ```gh-gist btnguyen2k/70a69d8880eacbbaf04f5522cd3acd4a
    ```
    ]]
```

# Lời kết

Chúng ta đã cùng nhau giải bài thực hành chuyển 1 số thập phân sang hệ cơ số 32 và ngược lại, dùng bảng mã kiểm [Crockford Base32](/cms/others/crockford-base32/). Bài tập này giúp bạn củng cố kiến thức về nhập/xuất dữ liệu, tạo và sử dụng hàm, vòng lặp và kiểm tra điều kiện/rẽ nhánh chương trình với các câu lệnh `if` và `switch/case`.

Lời giải trong bài viết là 1 cách giải tham khảo, _không phải là lời giải duy nhất_. Bạn hãy chủ động trải nghiệm với các cách giải khác nhau của riêng bạn.

Cuối cùng, chúc mừng bạn đã hoàn thành bài tập này!

<hr>

_[[do-tag ghissue_comment]]_
