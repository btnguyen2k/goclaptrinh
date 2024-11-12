```bs-alert info

[[do-tag tutorial_only]]
```

# Đề bài

```bs-alert primary

Viết chương trình Java, chuyển 1 số thập phân (ví dụ `12345`) sang hệ cơ số 32 sử dụng bảng mã [Crockford Base32](/cms/others/crockford-base32/) (ví dụ `C1S`).
```

Bài tập này củng cố kiến thức về:
- Nhập, xuất.
- Tạo và sử dụng method.
- Vòng lặp và rẽ nhánh.

_Xem bài viết giới thiệu về hệ cơ số 32 và bảng mã Crockford Base32 tại đây: [Crockford Base32](/cms/others/crockford-base32/)._

Để đơn giản, chương trình chỉ xử lý các số _nguyên dương_. Giả định rằng dữ liệu nhập vào luôn đúng định dạng, không cần kiểm tra dữ liệu nhập vào.

# Hướng dẫn bài giải

```bs-alert secondary

[[do-tag playground_java]]
```

### Nhập dữ liệu

Phần này đơn giản nên ta làm trước. Ta sẽ viết 2 hàm: 1 hàm nhập 1 số thập phân và 1 hàm nhập 1 số ở hệ cơ số 32 từ bàn phím:

```java
// file GocLapTrinh.java
import java.util.Scanner;

public class GocLapTrinh {
    static int nhapSoThapPhan(Scanner scanner) {
        System.out.print("Nhập số thập phân: ");
        return scanner.nextInt();
    }
    
    static String nhapSoBase32(Scanner scanner) {
        System.out.print("Nhập số ở hệ cơ số 32 (bảng mã Crockford Base32): ");
        return scanner.next();
    }
    
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        int n = nhapSoThapPhan(scanner);
        System.out.println("Số thập phân: " + n);

        String s = nhapSoBase32(scanner);
        System.out.println("Số ở hệ cơ số 32: " + s);

        scanner.close(); // đóng scanner khi hết sử dụng
    }
}
```

Để đọc dữ liệu từ bàn phím trong Java, ta sử dụng class `java.util.Scanner` và các method con để đọc các dữ liệu tương ứng. Để đọc vào 1 số thập phân (kiểu `int`) ta dùng method `nextInt()`, và để đọc vào 1 chuỗi ký tự (kiểu `String`) ta dùng method `next()`.

**Một số lưu ý khi dùng class `java.util.Scanner` để đọc từ bàn phím**:

Dữ liệu vào từ bàn phím thực chất là dòng dữ liệu từ stdin (standard input, xem thêm https://en.wikipedia.org/wiki/Standard_streams), được Java thể hiện qua biến `System.in`. Ta truyền `System.in` vào class `java.util.Scanner` khi khởi tạo.

Ta khởi tạo 1 đối tượng `Scanner` với `System.in` duy nhất và xuyên suốt toàn bộ chương trình. Bạn có thể nảy sinh ý tưởng là tạo đối tượng `Scanner` dùng riêng trong nội bộ mỗi hàm `nhapSoThapPhan` và `nhapSoBase32`, nhưng cách này thực sự không ổn. Chúng ta sẽ phân tích vấn đề này ở cuối bài viết.

Sau khi nhập xong dữ liệu, ta nên có thói quen đóng đối tượng `Scanner` để giải phóng tài nguyên bằng cách gọi method `Scanner.close()`. Trong các dự án thực tế, vì class `java.util.Scanner` implement interface `AutoCloseable`, ta có thể sử dụng pattern `try-with-resources` để đảm bảo rằng đối tượng `Scanner` sẽ luôn được tự động đóng khi không cần thiết nữa:

```java
try (Scanner scanner = new Scanner(System.in)) {
    // code xử lý dữ liệu
}
```

```bs-alert secondary

Ở các phần sau của bài viết, ta sẽ sử dụng pattern `try-with-resources` thay vì gọi `Scanner.close()` thủ công.
```

### Chuyển đổi số thập phân sang hệ cơ số 32

Kế tiếp, ta viết 1 hàm chuyển đổi số thập phân sang hệ cơ số 32.

```bs-alert secondary

Xem bài viết giới thiệu về hệ cơ số 32 và bảng mã Crockford Base32 tại đây: [Crockford Base32](/cms/others/crockford-base32/). Lưu ý rằng bảng mã Crockford Base32 sử dụng 10 chữ số (0-9) và 22 chữ cái (bảng chữ cái tiếng Anh bỏ đi các ký tự I, L, O, U), tổng cộng 32 ký tự.
```

```java
// file GocLapTrinh.java
public class GocLapTrinh {
    static String doiSangBase32(int n) {
        String base32 = "0123456789ABCDEFGHJKMNPQRSTVWXYZ";
        StringBuilder s = new StringBuilder();
        while (n > 0) {
            s.insert(0, base32.charAt(n % 32));
            n /= 32;
        }
        return s.toString();
    }

    public static void main(String[] args) {
        int n = 12345;
        String s = doiSangBase32(n);
        System.out.println("Số thập phân: " + n);
        System.out.println("Số ở hệ cơ số 32: " + s);
    }
}
```

Ở đây chúng ta áp dụng thuật toán đổi 1 số thập phân (ở hệ cơ số 10) sang một hệ cơ số khác (ở đây là hệ cơ số 32). Với 1 vài lưu ý:
- Bảng mã Crockford Base32 sử dụng bảng chữ cái tiếng Anh, nhưng loại bỏ số chữ ở giữa bảng chữ cái. Do vậy chúng ta cần phải tạo ra bảng mã mới mà không chứa các chữ cái bị loại bỏ.

### Chuyển đổi số ở hệ cơ số 32 sang thập phân

Ta xử lý nốt hàm chuyển đổi số ở hệ cơ số 32 sang hệ cơ số 10.

```java
// file GocLapTrinh.java
public class GocLapTrinh {
    static int charToNum(char c) {
        c = Character.toUpperCase(c); // chuyển thành ký tự in hoa
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
        String base32 = "0123456789ABCDEFGHJKMNPQRSTVWXYZ";
        for (int i = 0; i < 32; i++) {
            if (c == base32.charAt(i)) return i;
        }
        return -1;
    }

    static int doiSangThapPhan(String s) {
        int n = 0;
        for (int i = 0; i < s.length(); i++) {
            int num = charToNum(s.charAt(i));
            if (num == -1) return -1; // có ký tự không hợp lệ!
            n = n * 32 + num;
        }
        return n;
    }

    public static void main(String[] args) {
        String s = "C1S";
        int n = doiSangThapPhan(s);
        System.out.println("Số ở hệ cơ số 32: " + s);
        System.out.println("Số thập phân: " + n);
    }
}
```

Lưu ý:
- Dữ liệu nhập vào có thể bao gồm cả chữ hoa và chữ thường. Để chuẩn hoá, ta chuyển toàn bộ về chữ hoa.
- Crockford Base32 không dùng các  ký tự `I`, `L`, `O`, `U` khi chuyển từ số thập nhân sang base32. Nhưng vẫn chấp nhận các ký tự này khi chuyển từ base32 về thập phân với qui tắc:
  - `I` và `L` chuyển thành `1`.
  - `O` (ký tự O) chuyển thành `0` (số 0).
  - `U` chuyển thành `V`.

### Chương trình mẫu

Cuối cùng, ta có chương trình hoàn chỉnh:

```gh-gist btnguyen2k/136588e7a7fbc77c7674f7886874304f
```

# Lưu ý khi dùng `Scanner` đọc dữ liệu từ `System.in`

Trong bài tập này, ta sử dụng class `java.util.Scanner` để đọc dữ liệu từ `System.in`. Ta khởi tạo 1 đối tượng `Scanner` duy nhất và xuyên suốt toàn bộ chương trình. Bạn có thể nảy sinh ý tưởng là tạo đối tượng `Scanner` dùng riêng trong nội bộ mỗi hàm `nhapSoThapPhan` và `nhapSoBase32`, ví dụ như sau:

```java
static int nhapSoThapPhan() {
    try (Scanner scanner = new Scanner(System.in)) {
        System.out.print("Nhập số thập phân: ");
        return scanner.nextInt();
    }
}

static String nhapSoBase32() {
    try (Scanner scanner = new Scanner(System.in)) {
        System.out.print("Nhập số ở hệ cơ số 32 (bảng mã Crockford Base32): ");
        return scanner.next();
    }
}
```

Khi chạy chương trình, bạn sẽ exception tương tự như sau:

```plaintext
Exception in thread "main" java.util.NoSuchElementException
        at java.base/java.util.Scanner.throwFor(Scanner.java:937)
        at java.base/java.util.Scanner.next(Scanner.java:1478)
        at GocLapTrinh.nhapSoBase32(GocLapTrinh.java:14)
        at GocLapTrinh.main(GocLapTrinh.java:66)
```

Lý do là vì sau khi đọc dữ liệu lần đầu tiên, chúng ta đóng `Scanner` và giải phóng các resource đi kèm theo, **trong đó có `System.in`**! Mà khi `System.in` bị đóng rồi, lần kế tiếp khi chúng ta tạo `Scanner` mới, `Scanner` không thể đọc dữ liệu từ `System.in` được nữa. Mà nếu không đóng `Scanner` sau khi sử dụng thì cũng không phải là một ý tốt. Do vậy, cách tối ưu trong trường hợp này là tạo 1 đối tượng `Scanner` duy nhất và sử dụng nó xuyên suốt toàn bộ chương trình.

# Lời kết

Chúng ta đã cùng nhau giải bài thực hành chuyển 1 số thập phân sang hệ cơ số 32 và ngược lại, dùng bảng mã [Crockford Base32](/cms/others/crockford-base32/). Bài tập này giúp bạn củng cố kiến thức về nhập/xuất dữ liệu, tạo và sử dụng hàm, vòng lặp và kiểm tra điều kiện/rẽ nhánh chương trình với các câu lệnh `if` và `switch/case`.

Lời giải trong bài viết là 1 cách giải tham khảo, _không phải là lời giải duy nhất_. Bạn hãy chủ động trải nghiệm với các cách giải khác nhau của riêng bạn.

Cuối cùng, chúc mừng bạn đã hoàn thành bài tập này!

<hr>

_[[do-tag ghissue_comment]]_
