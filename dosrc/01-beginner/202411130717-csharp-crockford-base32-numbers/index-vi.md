```bs-alert info

[[do-tag tutorial_only]]
```

# Đề bài

```bs-alert primary

Viết chương trình C#, chuyển 1 số thập phân (ví dụ `12345`) sang hệ cơ số 32 sử dụng bảng mã [Crockford Base32](/cms/others/crockford-base32/) (ví dụ `C1S`).

**_Xem thêm các phiên bản khác của bài tập:_**
- [C/C++](/cms/beginner/c-cpp-crockford-base32-numbers/)
- [Java](/cms/beginner/java-crockford-base32-numbers/)
```

Bài tập này củng cố kiến thức về:
- Nhập, xuất.
- Tạo và sử dụng method.
- Vòng lặp và rẽ nhánh.

_Xem bài viết giới thiệu về hệ cơ số 32 và bảng mã Crockford Base32 tại đây: [Crockford Base32](/cms/others/crockford-base32/)._

Để đơn giản, chương trình chỉ xử lý các số _nguyên dương_. Giả định rằng dữ liệu nhập vào luôn đúng định dạng, không cần kiểm tra dữ liệu nhập vào.

# Hướng dẫn bài giải

```bs-alert secondary

[[do-tag playground_csharp]]
```

### Nhập dữ liệu

Ta bắt đầu chương trình với phần nhập/xuất dữ liệu. Ta sẽ viết 2 method: 1 method nhập 1 số thập phân và 1 method nhập 1 số ở hệ cơ số 32 từ bàn phím:

```csharp
using System;

class GocLapTrinh
{
    static int NhapSoThapPhan()
    {
        Console.Write("Nhap so thap phan: ");
        return int.Parse(Console.ReadLine() ?? string.Empty);
    }

    static string NhapSoBase32()
    {
        Console.Write("Nhap so o he co so 32 (bang ma Crockford Base32): ");
        return Console.ReadLine() ?? string.Empty;
    }

    static void Main()
    {
        var n = NhapSoThapPhan();
        Console.WriteLine($"So thap phan: {n}");

        var s = NhapSoBase32();
        Console.WriteLine($"So base32: {s}");
    }
}
```

Để đọc dữ liệu từ bàn phím trong C#, ta sử dụng phương thức `ReadLine()` trong class `System.Console` để đọc vào 1 `string`. Với hàm `NhapSo32` thì như vậy là đủ vì ta cần đọc vào 1 chuỗi ký tự. Với hàm `NhapSoThapPhan`, ta cần chuyển chuỗi ký tự đọc được thành số nguyên; ta sử dụng phương thức `int.Parse` để chuyển từ `string` sang `int` và trả về kết quả.

Hiện tại, chương trình của chúng ta chưa xử lý gì thêm, mà chỉ đơn giản là in lại 2 giá trị mà ta vừa nhập vào ra màn hình. Ta dùng phương thức `Console.WriteLine` để in ra màn hình. Với `Console.WriteLine`, bạn có thể in thông tin ra màn hình theo 3 cách:

- Nối chuỗi: `Console.WriteLine("So thap phan: " + n);`
- String template: `Console.WriteLine("So thap phan: {0}", n);`
- Sử dụng cú pháp String interpolation (có từ .NET 6): `Console.WriteLine($"So thap phan: {n}");`

Trong đó "nối chuỗi" và "string interpolation" (từ .NET 6) bạn có thể sử dụng ở mọi nơi trong chương trình C#. String template chỉ sử dụng được ở các phương thức có hỗ trợ. Trong trường hợp này `Console.WriteLine` hỗ trợ string template.

Lưu ý rằng, từ .NET 6, nếu bạn tạo project dạng console app, chương trình có thể chỉ còn ngắn gọn như thế này:

```csharp
var n = NhapSoThapPhan();
Console.WriteLine($"So thap phan: {n}");

var s = NhapSoBase32();
Console.WriteLine($"So base32: {s}");

static int NhapSoThapPhan()
{
    Console.Write("Nhap so thap phan: ");
    return int.Parse(Console.ReadLine() ?? string.Empty);
}

static string NhapSoBase32()
{
    Console.Write("Nhap so o he co so 32 (bang ma Crockford Base32): ");
    return Console.ReadLine() ?? string.Empty;
}

// xem thêm thông tin về cấu trúc console app mới trong .NET 6 tại: https://aka.ms/new-console-template
```

Tuy nhiên, bài viết này sẽ sử dụng cấu trúc chương trình "truyển thống" hơn để bạn có thể chạy được ứng dụng trên 1 số tool online (ví dụ như https://www.onlinegdb.com/).

Sau khi nhập dữ liệu, ta sẽ tiếp tục viết 2 method chuyển đổi số thập phân sang hệ cơ số 32 và ngược lại.

### Chuyển đổi số thập phân sang hệ cơ số 32

Kế tiếp, ta viết 1 hàm chuyển đổi số thập phân sang hệ cơ số 32.

```bs-alert secondary

Xem bài viết giới thiệu về hệ cơ số 32 và bảng mã Crockford Base32 tại đây: [Crockford Base32](/cms/others/crockford-base32/). Lưu ý rằng bảng mã Crockford Base32 sử dụng 10 chữ số (0-9) và 22 chữ cái (bảng chữ cái tiếng Anh bỏ đi các ký tự I, L, O, U), tổng cộng 32 ký tự.
```

```csharp
using System;

class GocLapTrinh
{
    static string DoiSangBase32(int n)
    {
        var base32 = "0123456789ABCDEFGHJKMNPQRSTVWXYZ";
        var s = "";
        while (n > 0)
        {
            s = base32[n % 32] + s;
            n /= 32;
        }
        return s;
    }
    
    static void Main()
    {
        var n = 12345;
        Console.WriteLine($"So thap phan: {n}, doi sang base32: {DoiSangBase32(n)}");
    }
}
```

Ở đây chúng ta áp dụng thuật toán đổi 1 số thập phân (ở hệ cơ số 10) sang một hệ cơ số khác (ở đây là hệ cơ số 32). Với 1 vài lưu ý:
- Bảng mã Crockford Base32 sử dụng bảng chữ cái tiếng Anh, nhưng loại bỏ số chữ ở giữa bảng chữ cái. Do vậy chúng ta cần phải tạo ra bảng mã mới mà không chứa các chữ cái bị loại bỏ.

### Chuyển đổi số ở hệ cơ số 32 sang thập phân

Ta xử lý nốt hàm chuyển đổi số ở hệ cơ số 32 sang hệ cơ số 10.

```csharp
using System;

class GocLapTrinh
{
    static int DoiSangThapPhan(string s)
    {
        var base32 = "0123456789ABCDEFGHJKMNPQRSTVWXYZ";
        var n = 0;
        s = s.ToUpper().Replace('I', '1').Replace('L', '1').Replace('O', '0').Replace('U', 'V');
        foreach (var c in s)
        {
            var i = base32.IndexOf(c);
            if (i == -1) return -1; // co ky tu khong hop le!
            n = n * 32 + i;
        }
        return n;
    }

    static void Main()
    {
        var s = "C1S";
        Console.WriteLine($"So base32: {s}, doi sang thap phan: {DoiSangThapPhan(s)}");
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

```gh-gist btnguyen2k/fb8f8d7803aaad0efb61d7c2a0736124
```

# Lời kết

Chúng ta đã cùng nhau giải bài thực hành chuyển 1 số thập phân sang hệ cơ số 32 và ngược lại, dùng bảng mã [Crockford Base32](/cms/others/crockford-base32/). Bài tập này giúp bạn củng cố kiến thức về nhập/xuất dữ liệu, tạo và sử dụng hàm, vòng lặp và kiểm tra điều kiện/rẽ nhánh chương trình với các câu lệnh `if` và `switch/case`.

Lời giải trong bài viết là 1 cách giải tham khảo, _không phải là lời giải duy nhất_. Bạn hãy chủ động trải nghiệm với các cách giải khác nhau của riêng bạn.

Cuối cùng, chúc mừng bạn đã hoàn thành bài tập này!

<hr>

_[[do-tag ghissue_comment]]_
