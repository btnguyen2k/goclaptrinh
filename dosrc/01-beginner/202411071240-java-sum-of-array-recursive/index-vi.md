```bs-alert info

[[do-tag tutorial_only]]
```

# Đề bài

```bs-alert primary

Java - Viết 1 hàm nhận vào 1 mảng số nguyên, tính tổng các phần tử của mảng và trả về kết quả, sử dụng phương pháp đệ qui.
```

Bài tập này củng cố kiến thức về:
- Đệ qui.
- Hàm trong Java.

Vì đề bài không có yêu cầu cụ thể về nhập/xuất dữ liệu, để đơn giản chúng ta sẽ chỉ tập trung vào viết hàm xử lý chính theo yêu cầu đề bài.

# Hướng dẫn bài giải

```bs-alert secondary

[[do-tag playground_java]]
```

Đầu tiên chúng ta nhắc lại một chút về khái niệm đệ qui. Đệ qui là một kỹ thuật lập trình mà trong đó một hàm gọi chính nó, để giải quyết bài toán mà có thể chia nhỏ bài toán gốc thành các bài toán con nhỏ hơn. Như vậy, nếu ta đặt tên cho hàm sắp viết là `sumOfArray`, thì chúng ta sẽ có thuật toán giải như sau: tổng các phần tử của 1 mảng N phần tử sẽ bằng tổng phần tử đầu tiên cộng với tổng các phần tử còn lại của mảng N-1 phần tử. Biểu diễn thành công thức:

```java
sumOfArray(arr[0..n-1]) = arr[0] + sumOfArray(arr[1..n-1])
```

Một điểm quan trọng của đệ qui là điều kiện dừng. Trong bài toán của chúng ta, điều kiện dừng là khi mảng không còn phần tử nào (mảng rỗng) hoặc mảng nhận vào là `null`. Lú này hàm sẽ trả về kết quả là `0`.

Như vậy ta có lời giải như sau:

```java
import java.util.Arrays;

public class Main {
    /**
     * Tính tổng các phần tử của mảng sử dụng đệ qui.
     * @param arr mảng số nguyên.
     * @return tổng các phần tử của mảng.
     */
    public static int sumOfArray(int[] arr) {
        if (arr == null || arr.length == 0) {
            // Điều kiện dừng: trả về 0 nếu mảng rỗng hoặc null.
            return 0;
        }

        // lấy N-1 phần tử còn lại, đưa vào 1 mảng mới
        int[] leftOver = Arrays.copyOfRange(arr, 1, arr.length);

        // thực hiện công thức đệ qui.
        return arr[0] + sumOfArray(leftOver);
    }

    public static void main(String[] args) {
        int[] arr = {1, 2, 3, 4, 5};
        System.out.println(sumOfArray(arr)); // kết quả: 15
    }
}
```

# Lời kết

Chúng ta đã cùng nhau giải bài thực hành tính tổng các phần tử của mảng sử dụng đệ qui trong Java. Bài tập này giúp bạn củng cố kiến thức về đệ qui cũng như viết hàm trong Java.

Lời giải trong bài viết là 1 cách giải tham khảo, _không phải là lời giải duy nhất_. Bạn hãy chủ động trải nghiệm với các cách giải khác nhau của riêng bạn.

Cuối cùng, chúc mừng bạn đã hoàn thành bài tập này!

<hr>

_[[do-tag ghissue_comment]]_
