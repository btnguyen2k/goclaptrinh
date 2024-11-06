Base32 mà một phương thức mã hoá và giải mã dữ liệu sử dụng hệ chữ cái gồm 32 ký tự. Base32 trong một số ngữ cảnh có thể được gọi là "hệ cơ số 32". Base32 có nhiều phiên bản, ví dụ [Base32 RFC 4648](https://en.wikipedia.org/wiki/Base32#RFC_4648_encodings) hoặc [z-base-32](https://en.wikipedia.org/wiki/Base32#RFC_4648_encodings). Trong bài viết này chúng ta sẽ tìm hiểu về [Crockford Base32](https://www.crockford.com/base32.html), một phiên bản của Base32 được tạo ra bởi [Douglas Crockford](https://en.wikipedia.org/wiki/Douglas_Crockford).

# Bảng mã Crockford Base32

Bảng mã 32 chữ cái của Crockford Base32 bao gồm:
- 10 chữ số: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
- 22 chữ trong bảng chữ cái tiếng Anh, bỏ đi các chữ I L O U. Các chữ cái được chọn bỏ đi để tránh nhầm lẫn trong 1 số trường hợp, như chữ I (hoa) và chữ l (thường), chữ O và số 0, chữ U và chữ V.

Như vậy để chuyển đổi từ hệ số thập phân sang Crockford Base32, chúng ta có bảng sau

| Thập phân | Crockford Base32 | Thập phân | Crockford Base32 |
|:---------:|:----------------:|:---------:|:----------------:|
| 0         | 0                | 16        | G                |
| 1         | 1                | 17        | H                |
| 2         | 2                | 18        | J                |
| 3         | 3                | 19        | K                |
| 4         | 4                | 20        | M                |
| 5         | 5                | 21        | N                |
| 6         | 6                | 22        | P                |
| 7         | 7                | 23        | Q                |
| 8         | 8                | 24        | R                |
| 9         | 9                | 25        | S                |
| 10        | A                | 26        | T                |
| 11        | B                | 27        | V                |
| 12        | C                | 28        | W                |
| 13        | D                | 29        | X                |
| 14        | E                | 30        | Y                |
| 15        | F                | 21        | Z                |

Và để chuyển ngược lại từ Crockford Base32 sang hệ số thập phân:

| Crockford Base32 | Thập phân | Crockford Base32 | Thập phân |
|:----------------:|:---------:|:----------------:|:---------:|
| 0 hoặc O hoặc o  | 0         | G hoặc g         | 16        |
| 1 hoặc I i L l   | 1         | H hoặc h         | 17        |
| 2                | 2         | J hoặc j         | 18        |
| 3                | 3         | K hoặc k         | 19        |
| 4                | 4         | M hoặc m         | 20        |
| 5                | 5         | N hoặc n         | 21        |
| 6                | 6         | P hoặc p         | 22        |
| 7                | 7         | Q hoặc q         | 23        |
| 8                | 8         | R hoặc r         | 24        |
| 9                | 9         | S hoặc s         | 25        |
| A hoặc a         | 10        | T hoặc t         | 26        |
| B hoặc b         | 11        | V hoặc v         | 27        |
| C hoặc c         | 12        | W hoặc w         | 28        |
| D hoặc d         | 13        | X hoặc x         | 29        |
| E hoặc e         | 14        | Y hoặc y         | 30        |
| F hoặc f         | 15        | Z hoặc z         | 31        |

# Mã hoá và giải mã dùng bảng mã Crockford Base32

Để mã hoá (encoding) 1 chuỗi dữ liệu thành Crockford Base32, chúng ta thực hiện các bước sau:

- Chuyển mỗi byte của chuỗi dữ liệu thành các bit, ta sẽ có 1 _chuỗi bit_.
- Chia chuỗi bit thành các nhóm _5 bit_, tính từ trái sang phải. Mỗi nhóm 5 bit sẽ tương ứng với 1 số từ 0 đến 31.
- Dùng bảng mã Crockford Base32 để chuyển mỗi nhóm 5 bit thành 1 ký tự trong Crockford Base32 theo bảng mã ở trên.
- Nếu nhóm cuối cùng không đủ 5 bit, thêm các bit 0 vào cuối cho đủ 5 bit, sau đó chuyển thành ký tự Crockford Base32.

Ta thử 1 ví dụ với chuỗi dữ liệu là `Goc Lap Trinh`, ta có được chuỗi bit tương ứng như sau

|   Ký Tự   |    G     |    o     |    c     |          |    L     |    a     |    p     |          |    T     |    r     |    i     |    n     |    h     |
|:---------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|:--------:|
| Thập nhân |    71    |   111    |    99    |    32    |    76    |    97    |   112    |    32    |    84    |   114    |   105    |   110    |   104    |
| Nhị phân  | 01000111 | 01101111 | 01100011 | 00100000 | 01001100 | 01100001 | 01110000 | 00100000 | 01010100 | 01110010 | 01101001 | 01101110 | 01101000 |

```bs-alert secondary

71 là giá trị trong bảng mã ASCII của G, đổi ra nhị phân ta được 01000111;
111 là giá trị trong bảng mã ASCII của o, đổi ra nhị phân ta được 01101111;
32 là giá trị trong bảng mã ASCII của khoảng trắng, đổi ra nhị phân ta được 00100000;
và cứ như vậy cho các ký tự còn lại.
```

Gom thành các nhóm 5 bit và chuyển thành Crockford Base32, ta có kết quả sau:

| Binary           | 01000 | 11101 | 10111 | 10110 | 00110 | 01000 | 00010 | 01100 | 01100 | 00101 | 11000 | 00010 | 00000 | 10101 | 00011 | 10010 | 01101 | 00101 | 10111 | 00110 | 10000 |
|------------------|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|:-----:|
| Thập phân        |   8   |  29   |  23   |  22   |   6   |   8   |   2   |  12   |  12   |   5   |  24   |   2   |   0   |  21   |   3   |  18   |  13   |   5   |  23   |   6   |  16   |
| Crockford Base32 |   8   |   X   |   Q   |   P   |   6   |   8   |   2   |   C   |   C   |   5   |   R   |   2   |   0   |   N   |   3   |   J   |   D   |   5   |   Q   |   6   |   G   |

Như vậy chuỗi `Goc Lap Trinh` sau khi mã hoá bằng Crockford Base32 sẽ trở thành `8XQP682CC5R20N3JD5Q6G`.

Quá trình giải mã (decoding) sẽ là quá đảo ngược của quá trình mã hoá. Với chuỗi `8XQP682CC5R20N3JD5Q6G`, ta tách ra từng ký tự, chuyển thành các nhóm 5 bit, ta được chuỗi bit sau: `010001110110111101100011001000000100110001100001011100000010000001010100011100100110100101101110011010000`. Chia thành các nhóm 8 bit, và chuyển mỗi nhóm thành ký tự ASCII, ta có kết quả:

|  Binary  | Thập phân |  ASCII  |
|:--------:|:---------:|:-------:|
| 01000111 |    71     |   G     |
| 01101111 |    111    |    o    |
| 01100011 |    99     |    c    |
| 00100000 |    32     | (space) |
| 01001100 |    76     |    L    |
| 01100001 |    97     |    a    |
| 01110000 |    112    |    p    |
| 00100000 |    32     | (space) |
| 01010100 |    84     |    T    |
| 01110010 |    114    |    r    |
| 01101001 |    105    |    i    |
| 01101110 |    110    |    n    |
| 01101000 |    104    |    h    |

Riêng nhóm cuối là `0`, không đủ 8 bit, ta bỏ qua.

# Checksum

Các ứng dụng khi sử dụng Crockford Base32 có thể thêm 1 ký tự checksum ở cuối chuỗi mã hóa nhằm mục đích phát hiện lỗi của dữ liệu nếu có phát sinh trong quá trình truyền tải. Ký tự checksum được tính bằng cách lấy giá trị sau khi encoding, chia lấy số dư cho 37, và lấy ký tự tương ứng trong bảng mã Crockford Base32. Khi chia lấy số dư cho 37, ta có thể được 1 giá trị từ 0 đến 36. Nhưng vì bảng mã Crockford Base32 chỉ tương ứng với giá trị từ 0 đến 31, nên ta cần thêm 5 giá trị nữa vào bảng mã. Các giá trị được sử dụng là:

| Thập phân | Crockford Base32 |
|:---------:|:----------------:|
|    32     |        *         |
|    33     |        ~         |
|    34     |        $         |
|    35     |        =         |
|    36     |        U         |

Ví dụ, với chuỗi `Goc Lap Trinh`, sau khi mã hoá ta được chuỗi `8XQP682CC5R20N3JD5Q6G`, checksum của chuỗi này sẽ là `*`. Do vậy chuỗi mã hoá nếu có checksum sẽ là `8XQP682CC5R20N3JD5Q6G*`.

# Tài liệu tham khảo

- [Crockford Base32](https://www.crockford.com/base32.html).
- Một số [bài tập thực hành](/cms/_search?q=Crockford+Base32) với Crockford Base32.

<hr>

_[[do-tag ghissue_comment]]_
