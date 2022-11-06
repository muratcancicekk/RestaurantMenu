# AppnomiCase

## Base Katmanların Oluşturulması
Öncelik ile network ve model sayfalarını oluşturdum. Network katmanını generic yazdım ve bu sayede kod kalabalığından kurtulup daha temiz bir yapı ortaya çıktı.
Sonrasında BaseViewController oluşturdum.

## Kategori sayfası
Tasarımını oluşturduğum kategori sayasında ViewModel oluşuturup network katmanında kurduğum yapı ile gerekli yere istek atıp dönen sonucu View'de gösterdim.

![Screen Shot 2022-09-12 at 13 31](https://user-images.githubusercontent.com/62101026/189632691-5a5332b3-e7e3-4282-9de9-3b71019f7f0a.png)

## Ürün Listesi Sayfası

Seçilen kategorinin ürünlerini listeleyen bir yapı oluşturdum, bu yapıya ek filtreleme seçeneği koydum ve bize gelen listeyi filtreleyip kullanabildik.

![Screen Shot 2022-09-12 at 13 54 -3](https://user-images.githubusercontent.com/62101026/189636693-1c7e93ce-a68d-4c2f-847e-a9f89076e4d9.png)
![Screen Shot 2022-09-12 at 13 54 -2](https://user-images.githubusercontent.com/62101026/189636605-27422bcb-4ba8-4871-b8f7-097033a6e578.png)

## Detay Sayfası

Ürün listesindeki ürünün detaylarını bu sayfada gösterebilmekteyiz. Stokta kalıp kalmadığı açıklaması ve indirimli fiyat var ise gösterilmesi gibi özellikler burada bulunmaktadır. Sağ üst köşede sepet butonu bulunmakta şuanlık bir işlevi olmayan buton tıklanıldığı zaman print etmektedir.

![Screen Shot 2022-09-12 at 13 58](https://user-images.githubusercontent.com/62101026/189637457-8226c6f0-9d19-47a2-b7f7-1281c4d082b3.png)

## Kullandığım Teknolojiler
- SnapKit
- Swiftlint
- UIkit Programmatically
- MVVM Mimarisine uygun yazılmıştır

## Preview 


https://user-images.githubusercontent.com/62101026/189639777-b5e814e6-a695-4cc0-8883-3cc7489b1d89.mp4

