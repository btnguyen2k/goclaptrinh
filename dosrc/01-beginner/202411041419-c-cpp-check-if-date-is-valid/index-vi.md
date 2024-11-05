```bs-alert info

[[do-tag tutorial_only]]
```

# Đề bài

```bs-alert primary

Viết chương trình C hoặc C++, nhập vào ngày, tháng, năm từ bàn phím. Kiểm tra xem ngày, tháng, năm đó có hợp lệ không.
```

Bài tập này củng cố kiến thức về:
- Nhập (từ bàn phím), xuất (ra màn hình).
- Kiểm tra điều kiện và rẽ nhánh chương trình với câu lệnh `if` và `switch/case`.

Để đơn giản, chúng ta sẽ nhập ngày, tháng, năm riêng biệt từ bàn phím. Và giá trị của năm sẽ nằm trong khoảng từ 1900 đến 2100.

# Hướng dẫn bài giải

```bs-alert secondary

[[do-tag playground_ccpp]]
```

### Nhập ngày, tháng, năm

Đầu tiên ta xử lý phần nhập ngày, tháng, năm từ bàn phím.

```bs-tabs
    [[bs-tab main.c
    ```c
    /* Chương trình C kiểm tra ngày, tháng, năm nhập từ bàn phím có hợp lệ hay không */

    #include <stdio.h>

    int main() {
        // Do bài viết trên web nên dùng tiếng Việt có dấu cho dễ đọc.
        // Trên thực tế, cửa sổ Command Prompt trên Windows có thể không hỗ trợ tiếng Việt Unicode. Bạn có thể sử dụng
        // tieng Viet khong dau or English
        // đều được hết nha.

        printf("Chương trình kiểm tra tính hợp lệ của 1 ngày/tháng/năm nhập vào từ bàn phím\n");

        int ngay, thang, nam;

        printf("Nhập ngày : ");
        scanf("%d", &ngay);

        printf("Nhập tháng: ");
        scanf("%d", &thang);

        printf("Nhập năm  : ");
        scanf("%d", &nam);

        printf("Ngày vừa nhập là: %02d/%02d/%04d\n", ngay, thang, nam);

        return 0;
    }
    ```
    ]]

    [[bs-tab main.cpp
    ```cpp
    /* Chương trình C++ kiểm tra ngày, tháng, năm nhập từ bàn phím có hợp lệ hay không */

    #include <iostream>

    int main() {
        // Do bài viết trên web nên dùng tiếng Việt có dấu cho dễ đọc.
        // Trên thực tế, cửa sổ Command Prompt trên Windows có thể không hỗ trợ tiếng Việt Unicode. Bạn có thể sử dụng
        // tieng Viet khong dau or English
        // đều được hết nha.

        std::cout << "Chương trình kiểm tra tính hợp lệ của 1 ngày/tháng/năm nhập vào từ bàn phím" << std::endl;

        int ngay, thang, nam;

        std::cout << "Nhập ngày : ";
        std::cin >> ngay;
        
        std::cout << "Nhập tháng: ";
        std::cin >> thang;

        std::cout << "Nhập năm  : ";
        std::cin >> nam;

        std::cout << "Ngày vừa nhập là: " << ngay << "/" << thang << "/" << nam << std::endl;

        return 0;
    }
    ```
    ]]
```

Khi chạy chương trình, bạn sẽ nhận được kết quả như sau

```bs-tabs
    [[bs-tab main.c
    ```terminal
    $ ./main
    Chương trình kiểm tra tính hợp lệ của 1 ngày/tháng/năm nhập vào từ bàn phím
    Nhập ngày : 5
    Nhập tháng: 11
    Nhập năm  : 2024
    Ngày vừa nhập là: 05/11/2024
    ```
    ]]

    [[bs-tab main.cpp
    ```terminal
    $ ./main
    Chương trình kiểm tra tính hợp lệ của 1 ngày/tháng/năm nhập vào từ bàn phím
    Nhập ngày : 31
    Nhập tháng: 02
    Nhập năm  : 2025
    Ngày vừa nhập là: 31/2/2025
    ```
    ]]
```

Đầu chương trình, theo phép "lịch sự" ta in ra 1 dòng thông báo để người dùng biết chương trình đang chạy là để làm gì.

Trong C, ta dùng hàm `printf` để in thông tin ra màn hình, trong trường hợp này là 1 chuỗi ký tự - chính là dòng thông báo. Hàm này ở trong thư viện `stdio.h` - đó là lý do ta có dòng `#include <stdio.h>` ở đầu chương trình để báo rằng "chương trình của tôi sẽ sử dụng các hàm trong thư viện `stdio.h`".
Chuỗi `\n` ở cuối dòng lệnh `printf` là _ký tự xuống dòng_. Nếu không có nó, chương trình khi chạy sẽ ra như thế này:

```terminal
$ ./main
Chương trình kiểm tra tính hợp lệ của 1 ngày/tháng/năm nhập vào từ bàn phímNhập ngày : 5
```

Với C++, ta dùng `std::cout << thông tin` để in phần `thông tin` ra màn hình. Hàm này ở trong thư viện `iostream`, nên ta khai báo sử dụng thư viện này bằng câu lệnh `#include <iostream>` ở đầu chương trình. Và tương tự, ta dùng `std::endl` ở cuối dòng lệnh để in ký tự "xuống dòng". Bạn có thể "nối" liên tiếp nhiều thông tin cần in lần lượt từ trái sang phải bằng dấu `<<`, ví dụ:

```cpp
std::cout << "Chương trình kiểm tra tính hợp lệ của 1 " << "ngày/tháng/năm" << " nhập vào từ bàn phím" << std::endl;
```

```bs-alert secondary

Trong C++ bạn có thể sử dụng cú pháp và các hàm của C như `printf`. Nhưng trong bài tập này, chương trình C++ ta sử dụng cú pháp chuẩn C++ "cho nó sang".
```

Kế tiếp chúng ta khai báo 3 biến để lưu trữ giá trị ngày, tháng và năm. Bạn có thể khai báo mỗi biến 1 dòng, ví dụ:

```c
int ngay;
int thang;
int nam;
```

hoặc khai báo 1 lúc 3 biến trên 1 dòng `int ngay, thang, nam;`. Bạn có thể đặt tên biến bằng tiếng Việt (`ngay, thang, nam`) hoăc tiếng Anh (`day, month, year`) đều không có vấn đề chi cả. Điểm quan trọng là ở đây là _kiểu dữ liệu_ của biến: giá trị của ngày, tháng, năm là số nguyên nên ta dùng kiểu dữ liệu `int`.

```bs-alert secondary

Ngày, tháng, năm không có giá trị âm, nên chúng ta có thể sử dụng kiểu dữ liệu `unsigned int` để biểu thị kiểu dữ liệu sẽ là "số nguyên dương". Nhưng để đơn giản, ta sẽ sử dụng kiểu dữ liệu `int` cho bài này, và sẽ kiểm tra giá trị nhập vào ở phần sau.
```

Sau khi khai báo các biến ngày, tháng, năm, ta yêu cầu ngưởi dùng sẽ nhập giá trị cho chúng từ bàn phím. Trong C, ta dùng hàm `scanf` để làm điều này, ví dụ `scanf("%d", &ngay);`. Ở đây có 2 điểm lưu ý:

- Tham số đầu tiên của hàm `scanf` là _định dạng_ cho kiểu dữ liệu mà bạn muốn nhập. Trong trường hợp này, `ngay` là kiểu dữ liệu số nguyên, nên ta dùng định dạng `%d`. Xem thêm về các định dạng khác trong tài liệu chi tiết của hàm `scanf` tại đây: https://cplusplus.com/reference/cstdio/scanf/
- `&` ở trước tên biến `ngay` là để lấy địa chỉ của biến. `&ngay` biểu thị rằng "lưu nội dung vào địa chỉ này nè" (mà cái địa chỉ "này" đang trỏ đến biến `ngay`).

Với C++ thì cú pháp đơn giản hơn một tí, ta dùng `std::cin >> ngay;` để nhập giá trị cho biến `ngay`. Để ý rằng trong C++ ta không cần phải chỉ định rõ định dạng dữ liệu nhập vào, cũng như không cần phải sử dụng địa chỉ của biến.

Cuối cùng, cũng theo phép "lịch sự", ta in lại ra màn hình giá trị ngày, tháng, năm mà người dùng vừa nhập vào. Trong C, tham số đầu tiên của hàm `printf` là _định dạng_ dữ liệu cần in ra (tương tự hàm `scanf`), các tham số tiếp theo là giá trị cần in ra. Lưu ý:

- Số lượng thông tin cần in phải khớp với số lượng tham số trong định dạng. Trường hợp này phần định dạng ta có 3 tham số `%02d`, `%02d` và `%02d` (ngăn cách nhau bằng ký tự `/`) tương ứng với 3 giá trị cần in ra là `ngay`, `thang` và `nam`.
- Định dạng `%02d` biểu thị "in ra số nguyên có 2 chữ số, nếu số nguyên có 1 chữ số thì thêm số 0 ở trước". Ví dụ, nếu `ngay` có giá trị là `5`, thì `%02d` sẽ in ra `05`. Đọc thêm về các định dạng của hàm `printf` tại đây: https://cplusplus.com/reference/cstdio/printf/

Với C++, ta dùng `std::cout` để in ra màn hình. Ta đã nói về `std::cout` ở bên trên, nên ở đây ta không lặp lại nữa.

```bs-alert secondary

Câu lệnh `return 0;` ở cuối chương trình biểu thị rằng "thoát khỏi hàm main", cũng có nghĩa là "chương trình kết thúc". Đây là 1 qui ước trong C/C++ để kết thúc chương trình khi bạn thoát khỏi hàm `main`.
```

### Kiểm tra tính hợp lệ của ngày, tháng, năm

Ta biết rằng giá trị của ngày là 1 số nguyên nằm trong khoảng `[1, 31]`, tháng là 1 số nguyên nằm trong khoảng `[1, 12]`, và giá trị của năm - theo đề bài - là 1 số nguyên nằm trong khoảng `[1900, 2100]`. Như vậy ta có thể viết phiên bản đầu tiên của phần kiểm tra ngày/tháng/năm như sau:

```bs-tabs
    [[bs-tab main.c
    ```c
    if (ngay < 1 || ngay > 31) {
        printf("Ngày/tháng/năm nhập vào KHÔNG hợp lệ\n");
        return 1;
    }
    if (thang < 1 || thang > 12) {
        printf("Ngày/tháng/năm nhập vào KHÔNG hợp lệ\n");
        return 1;
    }
    if (nam < 1900 || nam > 2100) {
        printf("Ngày/tháng/năm nhập vào KHÔNG hợp lệ\n");
        return 1;
    }
    printf("Ngày/tháng/năm nhập vào hợp lệ\n");
    return 0;
    ```
    ]]

    [[bs-tab main.cpp
    ```cpp
    if (ngay < 1 || ngay > 31) {
        std::cout << "Ngày/tháng/năm nhập vào KHÔNG hợp lệ" << std::endl;
        return 1;
    }
    if (thang < 1 || thang > 12) {
        std::cout << "Ngày/tháng/năm nhập vào KHÔNG hợp lệ" << std::endl;
        return 1;
    }
    if (nam < 1900 || nam > 2100) {
        std::cout << "Ngày/tháng/năm nhập vào KHÔNG hợp lệ" << std::endl;
        return 1;
    }
    ```
    ]]
```

- Trong đoạn mã trên, mỗi khi điều kiện kiểm tra không hợp lệ ta in ra thông báo và thoát khỏi chương trình ngay với câu lệnh `return 1;`. Do vậy ta không cần sử dụng câu lệnh `else` kèm với `if`.
- Bạn không nhất thiết sử dụng 1 khuôn mẫu logic kiểm tra như trên. Chúng tôi khuyến khích bạn thử các trải nghiệm khác nhau như thay đổi thứ tự kiểm tra ngày/tháng/năm. Hoặc kiểm tra theo một logic khác, ví dụ thay vì `if (ngay < 1 || ngay > 31)` bạn có thể dùng `if (!(ngay >= 1 && ngay <= 31))`; hoặc thử nghiệm `if` cùng với `else`, hay `if` lồng nhau, v.v. Hay thậm chí 1 câu lệnh `if` duy nhất cùng với các toán tử `||` hoặc `&&` để kiểm tra toàn bộ các điều kiện một lần.

Tới thời điểm này chương trình của chúng ta chạy, nhưng về logic thì chưa hoàn toàn đúng đắn. Không phải tháng nào cũng có số ngày như nhau: tháng 1, 3, 5, 7, 8, 10 và 12 có 31 ngày; tháng 4, 6, 9 và 11 có 30 ngày; và tháng 2 có 28 ngày. Ta có phiên bản tiếp theo của chương trình như sau:

```bs-tabs
    [[bs-tab main.c
    ```c
    if (nam < 1900 || nam > 2100) {
        printf("Ngày/tháng/năm nhập vào KHÔNG hợp lệ\n");
        return 1;
    }
    switch (thang) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            if (ngay < 1 || ngay > 31) {
                printf("Ngày/tháng/năm nhập vào KHÔNG hợp lệ\n");
                return 1;
            }
            break;
        case 4: case 6: case 9: case 11:
            if (ngay < 1 || ngay > 30) {
                printf("Ngày/tháng/năm nhập vào KHÔNG hợp lệ\n");
                return 1;
            }
            break;
        case 2:
            if (ngay < 1 || ngay > 28) {
                printf("Ngày/tháng/năm nhập vào KHÔNG hợp lệ\n");
                return 1;
            }
            break;
        default:
            // tháng không nằm trong khoảng [1, 12], nên dĩ nhiên là không hợp lệ
            printf("Ngày/tháng/năm nhập vào KHÔNG hợp lệ\n");
            return 1;
    }
    printf("Ngày/tháng/năm nhập vào hợp lệ\n");
    return 0;
    ```
    ]]

    [[bs-tab main.cpp
    ```cpp
    if (nam < 1900 || nam > 2100) {
        std::cout << "Ngày/tháng/năm nhập vào KHÔNG hợp lệ" << std::endl;
        return 1;
    }
    switch (thang) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            if (ngay < 1 || ngay > 31) {
                std::cout << "Ngày/tháng/năm nhập vào KHÔNG hợp lệ" << std::endl;
                return 1;
            }
            break;
        case 4: case 6: case 9: case 11:
            if (ngay < 1 || ngay > 30) {
                std::cout << "Ngày/tháng/năm nhập vào KHÔNG hợp lệ" << std::endl;
                return 1;
            }
            break;
        case 2:
            if (ngay < 1 || ngay > 28) {
                std::cout << "Ngày/tháng/năm nhập vào KHÔNG hợp lệ" << std::endl;
                return 1;
            }
            break;
        default:
            // tháng không nằm trong khoảng [1, 12], nên dĩ nhiên là không hợp lệ
            std::cout << "Ngày/tháng/năm nhập vào KHÔNG hợp lệ" << std::endl;
            return 1;
    }
    printf("Ngày/tháng/năm nhập vào hợp lệ\n");
    return 0;
    ```
    ]]
```

Ở phiên bản này, thay vì sử dụng `if` để kiểm tra giá trị của tháng và ngày, ta sử dụng `switch/case` để kiểm tra giá trị của ngày theo các trường hợp khác nhau của tháng.

Lúc này chương trình của chúng ta đã gần hoàn thiện, nhưng vẫn còn 1 trường hợp cần xử lý: vào năm nhuận thì tháng 2 sẽ có 29 ngày, thay vì 28 ngày như bình thường.

```bs-alert info

Năm nhuận xảy ra vào mỗi 4 năm 1 lần - số năm chia hết cho 4, ngoại trừ những năm chia hết cho 100 nhưng không chia hết cho 400. Ví dụ, năm 2000 là năm nhuận (chia hết cho 4 và 100 VÀ 400), nhưng năm 1900 không phải là năm nhuận (chia hết cho 4 và 100 nhưng KHÔNG chia hết cho 400).

Xem thêm: https://vi.wikipedia.org/wiki/N%C4%83m_nhu%E1%BA%ADn
```

Chúng ta chỉnh lại điều kiện kiểm tra ở phiên bản cuối cùng của chương trình như sau:

```bs-tabs
    [[bs-tab main.c
    ```c
    case 2:
        if ((nam % 4 == 0 && nam % 100 != 0) || nam % 400 == 0) {
            if (ngay < 1 || ngay > 29) {
                printf("Ngày/tháng/năm nhập vào KHÔNG hợp lệ\n");
                return 1;
            }
        } else {
            if (ngay < 1 || ngay > 28) {
                printf("Ngày/tháng/năm nhập vào KHÔNG hợp lệ\n");
                return 1;
            }
        }
        break;
    ```
    ]]

    [[bs-tab main.cpp
    ```cpp
    case 2:
        if ((nam % 4 == 0 && nam % 100 != 0) || nam % 400 == 0) {
            if (ngay < 1 || ngay > 29) {
                std::cout << "Ngày/tháng/năm nhập vào KHÔNG hợp lệ" << std::endl;
                return 1;
            }
        } else {
            if (ngay < 1 || ngay > 28) {
                std::cout << "Ngày/tháng/năm nhập vào KHÔNG hợp lệ" << std::endl;
                return 1;
            }
        }
        break;
    ```
    ]]
```

# Lời kết

Chúng ta đã cùng nhau giải bài thực hành kiểm tra ngày/tháng/năm nhập vào từ bàn phím có hợp lệ hay không. Bài tập này giúp bạn củng cố kiến thức về nhập/xuất, kiểm tra điều kiện và rẽ nhánh chương trình với câu lệnh `if` và `switch/case`.

Lời giải trong bài viết là 1 cách giải tham khảo, _không phải là lời giải duy nhất_. Bạn hãy chủ động trải nghiệm với các cách giải khác nhau của riêng bạn.

Cuối cùng, chúc mừng bạn đã hoàn thành bài tập này!

```bs-alert secondary

Trong bài viết có sử dụng các cụm từ "nhập từ bàn phím" và "xuất/in ra màn hình" là các cụ từ "bình dân" để mô tả hành động nhập/xuất dữ liệu. Trong thực tế, chương trình sẽ đọc dữ liệu đầu vào từ 1 dòng dữ liệu gọi là standard input (hoặc viết tắt `stdin`), và xuất dữ liệu ra standard output (hoặc viết tắt `stdout`).

Xem thêm: https://en.wikipedia.org/wiki/Standard_streams
```

<hr>

_[[do-tag ghissue_comment]]_
