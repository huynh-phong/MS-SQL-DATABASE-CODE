--Câu 1. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.

SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc';

--Câu 2. In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.

SELECT MASP, TENSP
FROM SANPHAM
WHERE DVT IN ('quyen', 'cay');

--Câu 3. In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.

SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP LIKE ('B_01')

--Câu 4. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.

SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc' AND (GIA BETWEEN 30000 AND 40000);

--Câu 5. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000
--đến 40.000.

SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX IN ('Trung Quoc' , 'Thai Lan') AND GIA BETWEEN 30000 AND 40000;

--Câu 6. In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.

SELECT SOHD
FROM HOADON
WHERE NGHD IN ('2007-01-01', '2007-01-02')

--Câu 7. In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa
--đơn (giảm dần).

SELECT SOHD, NGHD, TRIGIA
FROM HOADON
WHERE NGHD BETWEEN '2007-01-01' AND '2007-01-31'
ORDER BY NGHD ASC, TRIGIA DESC;

--Câu 8. In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007

SELECT KHACHHANG.MAKH, KHACHHANG.HOTEN
FROM KHACHHANG JOIN HOADON 
ON KHACHHANG.MAKH = HOADON.MAKH 
WHERE HOADON.NGHD = '2007-01-01';

--Câu 9. In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006.

SELECT HOADON.SOHD, HOADON.TRIGIA 
FROM HOADON JOIN NHANVIEN
ON HOADON.MANV = NHANVIEN.MANV
WHERE NHANVIEN.HOTEN = 'Nguyen Van B' AND HOADON.NGHD = '2006-10-28';

--Câu 10. In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng
--10/2006.

SELECT SANPHAM.MASP, SANPHAM.TENSP
FROM KHACHHANG JOIN HOADON
ON KHACHHANG.MAKH = HOADON.MAKH JOIN CTHD
ON HOADON.SOHD = CTHD.SOHD JOIN SANPHAM
ON SANPHAM.MASP = CTHD.MASP
WHERE KHACHHANG.HOTEN = 'Nguyen Van A' AND MONTH(HOADON.NGHD) = 10 AND YEAR(HOADON.NGHD) = 2006;

--Câu 11. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.

SELECT DISTINCT SOHD
FROM CTHD
WHERE MASP = 'BB01' OR MASP = 'BB02';

--Câu 12. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10
--đến 20.

SELECT DISTINCT SOHD
FROM CTHD
WHERE (MASP = 'BB01' OR MASP = 'BB02') AND SL BETWEEN 10 AND 20;

--Câu 13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng
--từ 10 đến 20.

SELECT SOHD
FROM CTHD
WHERE MASP = 'BB01' AND SL BETWEEN 10 AND 20

INTERSECT

SELECT SOHD
FROM CTHD
WHERE MASP = 'BB02' AND SL BETWEEN 10 AND 20;

--Câu 14. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra
--trong ngày 1/1/2007.

SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'

UNION

SELECT SP.MASP, SP.TENSP
FROM SANPHAM SP JOIN CTHD CT 
ON SP.MASP = CT.MASP JOIN HOADON HD
ON CT.SOHD = HD.SOHD 
WHERE HD.NGHD = '2007-01-01';

--Câu 15. In ra danh sách các sản phẩm (MASP,TENSP) không bán được.

SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP NOT IN (SELECT MASP FROM CTHD)

--Câu 16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.

SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP NOT IN 
(SELECT CT.MASP
FROM HOADON HD JOIN CTHD CT
ON HD.SOHD = CT.SOHD
WHERE YEAR(HD.NGHD) = 2006)

--Câu 17. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.

SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc' AND MASP NOT IN 
(SELECT CT.MASP
FROM HOADON HD JOIN CTHD CT
ON HD.SOHD = CT.SOHD
WHERE YEAR(HD.NGHD) = 2006)

--Câu 18. Thống kê số lượng hóa đơn do mỗi nhân viên lập trong năm 2006, hiển thị (MANV, HOTEN, SoLuongHD).

SELECT NV.MANV, NV.HOTEN, COUNT(HD.SOHD) AS SoLuongHD
FROM HOADON HD JOIN NHANVIEN NV
ON HD.MANV = NV.MANV
WHERE YEAR(HD.NGHD)=2006
GROUP BY NV.MANV, NV.HOTEN;

--Câu 19. In ra danh sách nhân viên và tổng số khách hàng khác nhau mà họ đã bán hàng cho trong năm 2006.

SELECT NV.MANV, NV.HOTEN, COUNT(DISTINCT HD.MAKH) AS SoLuongKH
FROM NHANVIEN NV
LEFT JOIN HOADON HD 
ON NV.MANV = HD.MANV
AND YEAR(HD.NGHD)=2006
GROUP BY NV.MANV, NV.HOTEN;

--Câu 20.Liệt kê sản phẩm (MASP, TENSP) có tổng số lượng bán ra nhiều nhất trong năm 2006.

SELECT TOP 1 WITH TIES SP.MASP, SP.TENSP, SUM(CT.SL) AS TongSL
FROM SANPHAM SP
JOIN CTHD CT ON SP.MASP = CT.MASP
JOIN HOADON HD ON CT.SOHD = HD.SOHD
WHERE YEAR(HD.NGHD) = 2006
GROUP BY SP.MASP, SP.TENSP
ORDER BY TongSL DESC;

--Câu 21. Tìm nhân viên có doanh số bán hàng cao nhất trong tháng 10/2006.

SELECT TOP 1 WITH TIES NV.MANV, NV.HOTEN, SUM(HD.TRIGIA) AS DoanhSoBH
FROM HOADON HD JOIN NHANVIEN NV
ON NV.MANV = HD.MANV 
WHERE MONTH(HD.NGHD) = 10 AND YEAR(HD.NGHD) = 2006
GROUP BY NV.MANV, NV.HOTEN
ORDER BY DoanhSoBH DESC;

--Câu 22. In ra danh sách sản phẩm không bán được trong năm 2007 nhưng có bán trong năm 2006.

(SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP NOT IN 
(SELECT CT.MASP
FROM HOADON HD JOIN CTHD CT
ON HD.SOHD = CT.SOHD
WHERE YEAR(HD.NGHD) = 2007))

INTERSECT

(SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP IN 
(SELECT CT.MASP
FROM HOADON HD JOIN CTHD CT
ON HD.SOHD = CT.SOHD
WHERE YEAR(HD.NGHD) = 2006))

--Câu 23. Liệt kê danh sách sản phẩm (MASP, TENSP) được bán bởi ít nhất 2 nhân viên khác nhau.

SELECT SP.MASP, SP.TENSP, COUNT(DISTINCT HD.MANV) AS SoNV
FROM SANPHAM SP JOIN CTHD CT
ON SP.MASP = CT.MASP JOIN HOADON HD
ON CT.SOHD = HD.SOHD
GROUP BY SP.MASP, SP.TENSP
HAVING COUNT(DISTINCT HD.MANV) >= 2;

--Câu 24. In ra danh sách khách hàng không mua sản phẩm nào do Thái Lan sản xuất.

SELECT MAKH, HOTEN
FROM KHACHHANG
WHERE MAKH NOT IN 
(SELECT KH.MAKH
FROM KHACHHANG KH JOIN HOADON HD
ON KH.MAKH = HD.MAKH JOIN CTHD CT
ON HD.SOHD = CT.SOHD JOIN SANPHAM SP
ON CT.MASP = SP.MASP
WHERE SP.NUOCSX = 'Thai Lan');

--Câu 25. Tìm hóa đơn có trị giá lớn nhất trong năm 2006, in ra (SOHD, NGHD, TRIGIA).

SELECT TOP 1 WITH TIES SOHD, NGHD, TRIGIA
FROM HOADON 
WHERE YEAR(NGHD) = 2006
ORDER BY TRIGIA DESC;
