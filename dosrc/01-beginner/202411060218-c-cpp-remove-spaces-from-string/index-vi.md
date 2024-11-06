```bs-alert info

[[do-tag tutorial_only]]
```

# Đề bài

```bs-alert primary

Viết chương trình C hoặc C++ xoá tất cả các khoảng trắng ở đầu và cuối 1 chuỗi, đồng thời xoá các khoảng trắng giữa ở giữa chuỗi chỉ giữ lại 1 khoảng trắng. Tổ chức chương trình thành các hàm để giải quyết bài toán.
```

Ví dụ, nếu nhận vào chuỗi:

```cpp
"  This is    a  string  with many spaces   "
```

Sau khi xử lý, chuỗi sẽ trở thành:

```cpp
"This is a string with many spaces"
```

Bài tập này củng cố kiến thức về:
- Xử lý chuỗi.
- Tổ chức chương trình thành các hàm để tái sử dụng.

Vì đề bài không có yêu cầu cụ thể về nhập/xuất dữ liệu, để đơn giản chúng ta sẽ chỉ tập trung vào viết các hàm xử lý chính. Chúng ta sẽ gán chuỗi cần xử lý vào 1 biến cố định thay vì nhập vào từ bàn phím.

# Hướng dẫn bài giải

```bs-alert secondary

[[do-tag playground_ccpp]]
```

### Phân tích yêu cầu & thiết kế

Trước khi xắn tay áo lên và gõ code, chúng ta phân tích một chút về yêu cầu đề bài và xây dựng kế hoạch giải quyết bài toán.

- "Khoảng trắng" không chỉ là ký tự space (`' '`), mà còn bao gồm ký tự tab (`'\t'`) và ký tự xuống dòng. Ký tự xuống dòng bao gồm 2 ký tự là `'\r'` và `'\n'` - tuỳ vào hệ điều hành qui định. Như vậy ta cần tính "khoảng trắng" là cả 4 ký tự này. Ta sẽ viết 1 hàm, đặt tên là `isEmptyChar`, để kiểm tra xem 1 ký tự có phải là "khoảng trắng" hay không.
- Để xoá các ký tự trắng ở đầu và cuối chuỗi, ta sẽ viết 2 hàm tương ứng, đặt tên là `removesLeadingSpaces` và `removesTrailingSpaces`.
- Và cuối cùng ta sẽ viết hàm `removesMiddleSpaces` để xoá các ký tự trắng thừa ở giữa chuỗi, chỉ giữ lại 1.

```bs-alert secondary

Một số ngôn ngữ trên thế giới có thể qui ước 1 số ký tự khác cũng là "khoảng trắng". Trong bài tập này, ta chỉ tính đến 4 ký tự "khoảng trắng" nếu ở trên trong bảng mã ASCII.
```

### Hàm `isEmptyChar`

Hàm này khá đơn giản, ta có thể viết như sau:

```bs-tabs
    [[bs-tab main.c
    ```c
    #include <stdbool.h>

    bool isEmptyChar(char c) {
        return c == ' ' || c == '\t' || c == '\r' || c == '\n';
    }
    ```
    ]]

    [[bs-tab main.cpp
    ```cpp
    bool isEmptyChar(char c) {
        return c == ' ' || c == '\t' || c == '\r' || c == '\n';
    }
    ```
    ]]
```

```bs-alert secondary

C ngày xưa không có kiểu dữ liệu `bool`, sau này được bổ sung vào thông qua thư viện `stdbool.h`. Do vậy với chương trình viết bằng C, ta có dòng `#include <stdbool.h>` để sử dụng kiểu dữ liệu `bool`. Trong C++, kiểu dữ liệu `bool` đã có sẵn.
```

### Hàm `removesLeadingSpaces` và `removesTrailingSpaces`

Trong C/C++, chuỗi có thể được biểu diễn bằng 1 mảng ký tự, hoặc con trỏ tới ký tự đầu tiên của chuỗi. Để thực hiện việc xoá các ký tự trắng ở đầu chuỗi, ta sẽ duyệt từ đầu chuỗi, "nhảy" qua các ký tự "khoảng trắng" cho tới khi gặp ký tự không phải "khoảng trắng" thì ta trả về con trỏ ở vị trí đó.

```cpp
char* removesLeadingSpaces(char* str) {
    while (isEmptyChar(*str)) {
        str++;
    }
    return str;
}
```

```bs-alert secondary

Bạn không cần phải lo lắng chương trình sẽ bị lỗi, hoặc crash nếu chuỗi truyền vào là rỗng (`""`) hoặc toàn khoảng trắng (ví dụ `"     "`). Chuỗi trong C luôn kết thức bằng 1 ký tự đặc biệt là `'\0'` (ký tự null). Khi đến cuối chuỗi, gặp ký tự này, hàm `isEmptyChar` sẽ trả về giá trị `false` và vòng lặp sẽ dừng lại.
```

Để xoá các ký tự trắng ở cuối chuỗi, ta sẽ duyệt lùi từ cuối chuỗi cho đến khi gặp ký tự không phải "khoảng trắng" thì đặt ký tự null (`'\0'`) để "cắt" chuỗi:

```cpp
#include <string.h>

char* removesTrailingSpaces(char* s) {
    int len = strlen(s);
    while (len > 0 && isEmptyChar(s[len - 1])) {
        len--;
    }
    s[len] = '\0';
    return s;
}
```

```bs-alert secondary

Trong hàm `removesTrailingSpaces`, ta sử dụng hàm `strlen` trong thư viện `string.h` để lấy độ dài chuỗi.
```

### Hàm `removesMiddleSpaces`

_Sau khi_ xoá các ký tự trắng ở đầu và cuối chuỗi, ta xử lý tới phần xoá các ký tự trắng thừa ở giữa chuỗi. Một cách để làm điều này là duyệt qua từng ký tự trong chuỗi, nếu gặp nhiều hơn 1 ký tự trắng liên tiếp thì chỉ giữ lại 1 ký tự trắng bằng cách "đôn" các ký tự phía sau lên.

```cpp
char* removesMiddleSpaces(char* s) {
    int n = strlen(s);
    int i, j = 0;
    int spaceCount = 0;

    for (i = 0; i < n; i++) {
        if (isEmptyChar(s[i])) {
            s[i] = ' '; // chuyển các thể loại ký tự trắng về space
            spaceCount++;
        } else {
            spaceCount = 0;
        }
        if (spaceCount <= 1) {
            s[j] = s[i];
            j++;
        }
    }

    s[j] = '\0'; // cát phần dư thừa của chuỗi
    return s;
}
```

Và cuối cùng, ta kết hợp các hàm lại với nhau để xử lý chuỗi theo yêu cầu đề bài:

```cpp
char* removesSpaces(char* s) {
    // đầu tiên xoá các khoảng trắng ở đâu và cuối chuỗi
    s = removesLeadingSpaces(s);
    s = removesTrailingSpaces(s);

    // sau đó xoá các khoảng trắng thừa ở giữa chuỗi
    s = removesMiddleSpaces(s);

    return s;
}
```

### Lời giải "thuần C++"

Bài giải của chúng ta cho tới thời điểm hiện tại sử dụng hoàn toàn các hàm và kiểu dữ liệu của C. Với C++, bạn có thể sử dụng `std::string` để lưu chuỗi và các hàm xử lý chuỗi được cung cấp sẵn trong thư viện chuẩn của C++. Ta có thể viết lại lời giải trên bằng C++ như sau:

```cpp
#include <string>
#include <algorithm>

bool notSpace(char c) {
    return !std::isspace(c);
}

std::string removeLeadingSpaces(std::string &s) {
    auto it = std::find_if(s.begin(), s.end(), notSpace);
    s.erase(s.begin(), it);
    return s;
}

std::string removeTailingSpaces(std::string &s) {
    auto it = std::find_if(s.rbegin(), s.rend(), notSpace);
    s.erase(it.base(), s.end());
    return s;
}

std::string removesExtraSpaces(const std::string& s) {
    std::string result;
    bool isSpace = false;

    for (char c : s) {
        if (std::isspace(c)) {
            if (!isSpace) {
                result += ' '; // chuyển các thể loại ký tự trắng về space
                isSpace = true;
            }
        } else {
            result += c;
            isSpace = false;
        }
    }

    return result;
}

std::string removeSpaces(std::string &s) {
    // đầu tiên xoá các khoảng trắng ở đâu và cuối chuỗi
    s = removeLeadingSpaces(s);
    s = removeTailingSpaces(s);

    // sau đó xoá các khoảng trắng thừa ở giữa chuỗi
    s = removesExtraSpaces(s);

    return s;
}
```

# Lời kết

Chúng ta đã cùng nhau giải bài thực hành xoá các khoảng trắng trong chuỗi bằng C và C++. Bài tập này giúp bạn củng cố kiến thức về xử lý chuỗi cũng như tổ chức chương trình thành các hàm để tái sử dụng.

Lời giải trong bài viết là 1 cách giải tham khảo, _không phải là lời giải duy nhất_. Bạn hãy chủ động trải nghiệm với các cách giải khác nhau của riêng bạn.

Cuối cùng, chúc mừng bạn đã hoàn thành bài tập này!

<hr>

_[[do-tag ghissue_comment]]_
