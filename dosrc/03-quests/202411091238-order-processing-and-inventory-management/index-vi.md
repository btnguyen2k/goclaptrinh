```bs-alert info

[[do-tag quest_intro]]
```

```bs-alert primary

**Đánh giá độ khó**: Bài tập nhiệm vụ này tương đương bài tập giữa kỳ môn lập trình cuối năm nhất/năm hai khoa Computer Science/Software Engineering ở một số trường đại học trên thế giới. Hãy thử sức xem trình của mình so với sinh viên các trường đó như thế nào ;)
```

# Đề bài

_GLT_ là một công ty thương mại điện tử nhỏ. Họ có 1 website nhận _đơn đặt hàng_ từ khách hàng. Đơn hàng sau đó được chuyển đến _kho hàng_ để xử lý. Do lệ thống phần mềm của còn rời rạc và chưa được đồng bộ, định kỳ GLT phải thực hiện việc kiểm tra đối soát giữa đơn hàng, kho hàng và doanh thu.

Thông tin kho hàng được export ra file `inventory.csv` với cấu trúc như sau: `sku,item_name,quantity,price` (sku, tên món hàng, số lượng trong kho, đơn giá). Ví dụ:

```csv
sku,item_name,quantity,price
A0001,ItemA-1,9.95
B0005,ItemB-5,15.50
...
```

Thông tin đơn hàng được cung cấp trong file `orders.csv` với cấu trúc như sau: `order_id,sku,quantity` (order_id, sku, số lượng). Ví dụ:

```csv
order_id,sku,quantity
O0001,A0001,2
O0002,B0005,1
...
```

```bs-alert secondary

SKU - Stock Keeping Unit - Đơn vị lưu kho, là một thuật ngữ trong lĩnh vực quản lý hàng tồn. Trong bài tập này, bạn có thể hiểu SKU như là ID của món hàng (`item_id`).
```

Nhiệm vụ của bạn là viết 1 chương trình duyệt qua 2 file `inventory.csv` và `orders.csv`, mô phỏng lại quá trình xử lý đơn hàng và kho hàng của GLT, và xuất ra thông tin tồn kho ở dạng CSV, lưu thành file `inventory_out.csv` với cấu trúc `sku,quantity` (sku, số lượng tồn).

Bạn cũng cần tổng hợp thông tin về các đơn hàng được bán thành công/thất bại, số tiền thu được và ghi vào file `orders_out.json` với cấu trúc như sau:

```json
{
  "total_revenue": 100.00, // tổng danh thu bán được
  "total_orders": 20, // tổng số đơn hàng
  "success_orders": 18, // số đơn hàng thành công
  "failed_orders": 2, // số đơn hàng thất bại
}
```

### Dữ liệu vào

Chương trình đọc dữ liệu hàng hóa từ file `inventory.csv`, mỗi dòng chứa thông tin của một mặt hàng với cấu trúc `sku,item_name,quantity,price`.

- Dòng đầu tiên của file `inventory.csv` là chuỗi `sku,item_name,quantity,price`, cho biết tên và thứ tự các trường của file. N dòng tiếp theo chứa thông tin của N mặt hàng.
- `sku` là 1 chuỗi (string), chỉ gồm các ký tự `a-zA-Z0-9`.
- `item_name` là 1 chuỗi (string), chỉ gồm các ký tự `a-zA-Z0-9`, khoảng trắng, gạch dưới `_`, gạch ngang `-`. Không chứa các ký tự đặc biệt khác.
- `quantity` là 1 số nguyên dương.
- `price` là 1 số thực, dương.

Dữ liệu đơn hàng được cung cấp trong file `orders.csv`, mỗi dòng chứa thông tin của một đơn hàng với cấu trúc `order_id,sku,quantity`.

- Dòng đầu tiên của file `orders.csv` là chuỗi `order_id,sku,quantity`, cho biết tên và thứ tự các trường của file. N dòng tiếp theo chứa thông tin của N đơn hàng.
- `order_id` là 1 chuỗi (string), chỉ gồm các ký tự `a-zA-Z0-9`.
- `sku` là 1 chuỗi (string), chỉ gồm các ký tự `a-zA-Z0-9`.
- `quantity` là 1 số nguyên dương.

### Dữ liệu ra

Chương trình xuất ra thông tin tồn kho ở dạng CSV, lưu thành file `inventory_out.csv` với cấu trúc `sku,quantity`:

- Dòng đầu tiên của file `inventory_out.csv` là chuỗi `sku,quantity`, cho biết tên và thứ tự các trường của file. N dòng tiếp theo chứa thông tin số lượng tồn của N mặt hàng.
- Thứ tự các mặt hàng trong file `inventory_out.csv` giống với với thứ tự trong file `inventory.csv`.

Ghi thông tin tổng hợp đơn hàng được bán thành công/thất bại và số tiền thu được `orders_out.json` với cấu trúc như sau:

```json
{
  "total_revenue": 100.00,
  "total_orders": 20,
  "success_orders": 18,
  "failed_orders": 2
}
```

Đơn hàng được xem là **thất bại** khi:
- Số lượng mặt hàng trong đơn hàng _vượt quá số lượng tồn kho_ hiện tại, hoặc
- SKU trong đơn hàng _không tồn tại_ trong kho hàng.

```bs-alert secondary

Do định dạng đặc biệt của JSON, thứ tự các trường `total_revenue`, `total_orders`, `success_orders` và `failed_orders` trong file `orders_out.json` có thể sắp xếp theo bất cứ thứ tự nào, không nhất thiết phải theo thứ tự như ví dụ ở trên. Ngoài ra, nội dung file JSON chỉ cần đảm bảo đúng cấu trúc, không cần đảm bảo định dạng đẹp. Tức là, nội dung file `orders_out.json` như thế này vẫn là 1 file JSON đúng: `{"total_orders": 20,"failed_orders": 2,"total_revenue": 100.00,"success_orders": 18}`.
```

### Thông tin tham khảo

- Định dạng CSV: [CSV - Wikipedia](https://en.wikipedia.org/wiki/Comma-separated_values).
- Định dạng JSON: [JSON - Wikipedia](https://en.wikipedia.org/wiki/JSON).
- Stock Keeping Unit (SKU): [Stock Keeping Unit - Wikipedia](https://en.wikipedia.org/wiki/Stock_keeping_unit).
- Kiểm tra cấu trúc & Định dạng file JSON: [JSONLint](https://jsonlint.com/).

# Gợi ý hướng giải

**Đọc dữ liệu từ file**. Một trong các bước quan trọng của chương trình là đọc dữ liệu từ file. Nhiều ngôn ngữ lập trình có hàm hoặc thư viện hỗ trợ đọc dữ liệu từ file CSV hoặc JSON. Tuy nhiên, CSV là 1 file text có cấu trúc khá đơn giản, bạn chỉ cần sử dụng các hàm đọc file text thông thường để đọc dữ liệu từ file CSV.

Lưu ý:
- Dòng đầu tiên của file CSV chứa thông tin về cấu trúc của file - tên và thứ tự các trường dữ liệu (bạn có thể bỏ qua dòng này).
- Dữ liệu cần xử lý nằm ở N dòng tiếp theo, mỗi dòng chứa trọn vẹn 1 record cần xử lý.
- Các trường dữ liệu trong mỗi dòng được phân tách bởi dấu phẩy `,`, tuy nhiên cũng có thể có khoảng trắng trước và sau dấu phẩy. Ví dụ `A0001, ItemA-1 , 9.95`.

**Xử lý business logic**. Sau khi bạn đọc được dữ liệu từ file, một hướng xử lý business logic đơn giản là xử lý tuần tự từng đơn hàng, từ đầu đến cuối file `orders.csv`. Bạn có thể tổ chức chương trình thành các hàm nhỏ, mỗi hàm xử lý 1 công đoạn giả lập qui trình xử lý đơn hàng - kiểm tra tồn kho - ghi nhận trạng thái đơn hàng - cập nhật số lượng tồn kho. Hoặc bạn cũng có thể tiếp cận bài toán theo hướng lập trình hướng đối tượng, với mỗi đối tượng trong chương trình mô phỏng 1 đối tượng trong thực tế, ví dụ `Order`, `Inventory`, `Item`.

**Ghi kết quả ra file**. Bước cuối khi xử lý xong dữ liệu, bạn cần xuất ra file kết quả. Đối với file CSV (`inventory_out.csv`), cấu trúc file CSV đã khá quen thuộc với bạn nên quá trình xuất dữ liệu ra file sẽ không quá phức tạp. Bạn cần lưu ý dòng đầu tiên của file CSV chứa thông tin về tên và thứ tự các trường dữ liệu (ví dụ `sku,quantity`).

Đối với file JSON (`orders_out.json`), đây cũng là 1 file dạng text, cấu trúc yêu cầu xuất ra trong bài tập này cũng khá đơn giản nên bạn hoàn toàn có thể tự tạo ra file JSON mà không cần sử dụng thư viện hỗ trợ. Tuy nhiên, nếu ngôn ngữ bạn sử dụng có sẵn hàm hoặc thư viện hỗ trợ xuất dữ liệu ra file JSON, bạn cũng có thể sử dụng chúng.

# Dữ liệu mẫu

### 10 mặt hàng + 20 đơn hàng

Bộ dữ liệu "mini" bạn có thể dùng để test chương trình. Dữ liệu đủ nhỏ để bạn có thể tự tính bằng tay và đối chiếu kết quả với chương trình.

```bs-tabs
    [[bs-tab inventory.csv
    ```csv
    sku,item_name,price,quantity
    AK0003,Item 000006,18.19,22
    WG0000,Item 000001,86.89,15
    WG0004,Item 000009,18.19,17
    AK0002,Item 000004,96.69,15
    WG0003,Item 000007,64.89,16
    WG0001,Item 000003,83.89,12
    AK0000,Item 000000,45.29,14
    WG0002,Item 000005,22.39,18
    AK0004,Item 000008,6.59,17
    AK0001,Item 000002,65.99,13
    ```
    ]]

    [[bs-tab orders.csv
    ```csv
    order_id,sku,quantity
    O000000,AK0002,3
    O000001,WG0004,2
    O000002,AK0002,9
    O000003,AK0002,2
    O000004,WG0002,4
    O000005,AK0000,4
    O000006,AK0001,9
    O000007,WG0002,6
    O000008,AK0000,4
    O000009,AK0003,10
    O00000A,WG0001,1
    O00000B,WG0001,5
    O00000C,WG0002,2
    O00000D,WG0004,2
    O00000E,AK0001,5
    O00000F,AK0004,5
    O000010,AK0003,6
    O000011,AK0002,3
    O000012,AK0000,8
    O000013,WG0002,3
    ```
    ]]

    [[bs-tab inventory_out.csv
    ```csv
    sku,quantity
    AK0003,6
    WG0000,15
    WG0004,13
    AK0002,1
    WG0003,16
    WG0001,6
    AK0000,6
    WG0002,3
    AK0004,12
    AK0001,4
    ```
    ]]

    [[bs-tab orders_out.json
    ```json
    {
        "total_revenue": 3545.83,
        "total_orders": 20,
        "success_orders": 17,
        "failed_orders": 3
    }
    ```
    ]]
```

### 100 mặt hàng + 1000 đơn hàng

Thử sức với lượng dữ liệu lớn hơn 1 chút. Download bộ dữ liệu input/output ở đây: https://github.com/btnguyen2k/goclaptrinh/tree/main/quests/order-processing-and-inventory-management/data100

### 10k mặt hàng + 1m đơn hàng

Nâng nhẹ độ khó lên một cấp với **10 ngàn** mặt hàng và **1 triệu** đơn hàng cần xử lý: https://github.com/btnguyen2k/goclaptrinh/tree/main/quests/order-processing-and-inventory-management/data10000

### 100k mặt hàng + 100m đơn hàng

Đẩy độ khó lên nhẹ một tẹo nữa với **100 ngàn** mặt hàng và **100 triệu** đơn hàng cần xử lý xem code của bạn chạy như thế nào: https://github.com/btnguyen2k/goclaptrinh/tree/main/quests/order-processing-and-inventory-management/data100000


```bs-alert warning

Do file dữ liệu khá hơn (> 1.5Gb) nên server đôi khi không đủ bandwidth để download. Nếu bạn gặp lỗi khi download, hãy thử lại sau một thời gian hoặc liên hệ tác giả bài viết (trên GitHub repo).
```

<hr>

_[[do-tag ghissue_comment]]_
