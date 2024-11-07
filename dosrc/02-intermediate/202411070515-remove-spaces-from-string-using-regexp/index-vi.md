```bs-alert info

[[do-tag tutorial_only]]
```

# Đề bài

```bs-alert primary

Viết chương trình sử dụng Regular Expression xoá tất cả các khoảng trắng ở đầu và cuối 1 chuỗi, đồng thời xoá các khoảng trắng giữa ở giữa chuỗi chỉ giữ lại 1 khoảng trắng.
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
- Regular Expression.

# Hướng dẫn bài giải

Chúng ta có 1 bài tập tương tự trong bộ "300 bài code thiếu nhi" ở [đây](/cms/beginner/c-cpp-remove-spaces-from-string/). Bài toán tương tự thế này bạn cũng có thể sẽ gặp ít nhiều trong thực tế. Trong các dự án thực tế, chúng ta sẽ không code theo cách như trong "300 bài code thiếu nhi" mà thường sẽ dùng 1 công cụ mạnh mẽ hơn, có sẵn trong nhiều ngôn ngữ lập trình, đó là Regular Expression (regexp).

```bs-alert secondary

Bài viết này tập trung vào Regular Expression thay vì 1 ngôn ngữ lập trình cụ thể. Bài viết sẽ cung cấp code mẫu trong 1 số ngôn ngữ lập trình, bạn có thể chạy thử trực tiếp online trên website https://www.onlinegdb.com/
```

Regexp để match tất cả các khoảng trắng ở đầu chuỗi: `^\s+`, và để match tất cả các khoảng trắng ở cuối chuỗi: `\s+$`. Một số ngôn ngữ hoặc thư viện cho phép match cùng lúc cả đầu và cuối chuỗi, lúc này ta có thể sử dụng regexp `^\s+|\s+$`. Và cuối cùng, để match tất cả các khoảng trắng ở giữa chuỗi ta dùng regexp: `\s+`.

```bs-alert secondary

Tuy cú pháp Regular Expression về nguyên tắt là giống nhau, nhưng mỗi ngôn ngữ lập trình sẽ có cách viết khác nhau đôi chút. Ví dụ cách escape ký tự đặt biệt, các flag qui định cách regexp xử lý chuỗi, v.v...
```

Với sự trợ giúp của Regular Expression, chúng ta sẽ tìm kiếm các khoảng trắng trong chuỗi bằng regexp và xoá hoặc thay thế bằng 1 khoảng trắng duy nhất theo yêu cầu của đề bài. Dưới đây là code ví dụ trong 1 số ngôn ngữ lập trình:

```bs-tabs
    [[bs-tab C++
    ```cpp
    #include <iostream>
    #include <string>
    #include <regex>

    std::string removeSpaces(const std::string &str) {
        return std::regex_replace(
            std::regex_replace(str, std::regex("^\\s+|\\s+$"), ""),
            std::regex("\\s+"), " ");
    }

    int main() {
        std::string str = "\r \t \nThis is\t\t\ta\n\t\rstring\twith many spaces.\r \t \n";
        std::cout << "[" << removeSpaces(str) << "]" << std::endl;
        return 0;

        // Kết quả in ra màn hình: [This is a string with many spaces.]
    }
    ```
    ]]

    [[bs-tab C#
    ```csharp
    using System;
    using System.Text.RegularExpressions;

    class Program {
        static string RemoveSpaces(string str) {
            return Regex.Replace(
                Regex.Replace(str, @"^\s+|\s+$", ""),
                @"\s+", " ");
        }

        static void Main() {
            string str = "\r \t \nThis is\t\t\ta\n\t\rstring\twith many spaces.\r \t \n";
            Console.WriteLine("[" + RemoveSpaces(str) + "]");

            // Kết quả in ra màn hình: [This is a string with many spaces.]
        }
    }
    ```
    ]]

    [[bs-tab Go
    ```go
    package main

    import (
        "fmt"
        "regexp"
    )

    func removeSpaces(str string) string {
        return regexp.MustCompile(`^\s+|\s+$`).ReplaceAllString(
            regexp.MustCompile(`\s+`).ReplaceAllString(str, " "), "")
    }

    func main() {
        str := "\r \t \nThis is\t\t\ta\n\t\rstring\twith many spaces.\r \t \n"
        fmt.Println("[" + removeSpaces(str) + "]")

        // Kết quả in ra màn hình: [This is a string with many spaces.]
    }
    ```
    ]]

    [[bs-tab Java
    ```java
    import java.util.regex.*;

    public class Main {
        public static String removeSpaces(String str) {
            return str.replaceAll("^\\s+|\\s+$", "").replaceAll("\\s+", " ");
        }

        public static void main(String[] args) {
            String str = "\r \t \nThis is\t\t\ta\n\t\rstring\twith many spaces.\r \t \n";
            System.out.println("[" + removeSpaces(str) + "]");

            // Kết quả in ra màn hình: [This is a string with many spaces.]
        }
    }
    ```
    ]]

    [[bs-tab JavaScript
    ```javascript
    function removeSpaces(str) {
        return str.replace(/^\s+|\s+$/g, "").replace(/\s+/g, " ");
    }

    let str = "\r \t \nThis is\t\t\ta\n\t\rstring\twith many spaces.\r \t \n";
    console.log("[" + removeSpaces(str) + "]");

    // Kết quả in ra màn hình: [This is a string with many spaces.]
    ```
    ]]

    [[bs-tab Python
    ```python
    import re

    def remove_spaces(s):
        return re.sub(r'\s+', ' ', re.sub(r'^\s+|\s+$', '', s))

    s = "\r \t \nThis is\t\t\ta\n\t\rstring\twith many spaces.\r \t \n"
    print(f"[{remove_spaces(s)}]")
    
    # Kết quả in ra màn hình: [This is a string with many spaces.]
    ```
    ]]
```

# Lời kết

Chúng ta đã dùng Regular Expression giải quyết nhiệm vụ xoá các khoảng trắng trong chuỗi. Hi vọng qua bài thực hành này bạn hiểu rõ hơn về Regular Expression cũng như cách ứng dụng vào dự án thực tế.

Lời giải trong bài viết là 1 cách giải tham khảo, _không phải là lời giải duy nhất_. Bạn hãy chủ động trải nghiệm với các cách giải khác nhau của riêng bạn.

Cuối cùng, chúc mừng bạn đã hoàn thành bài tập này!

<hr>

_[[do-tag ghissue_comment]]_
