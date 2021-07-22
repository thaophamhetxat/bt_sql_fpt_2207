use bt_sql_fpt_2207;

create table NhaCungCap(
MaNhaCC int primary key,
TenNhaCC nvarchar(30),
DiaChi nvarchar(50),
SoDT int,
MaSoThue int
);

create table MucPhi(
MaMP int primary key,
DonGia int,
MoTa nvarchar(30)
);


create table DichVu(
MaLoaiDV int primary key,
TenLoaiDV nvarchar(30)
);


create table Dongxe(
DongXe	 nvarchar(30) primary key,
HangXe nvarchar(30),
SoChoNgoi int
);



create table DangKyCungCap(
MaDKCC	 int primary key,
DK_MaNhaCC int,
DK_MaLoaiDV int,
Dk_DongXe nvarchar(30),
DK_MaMP int,
NgayBatDauCungCap date,
NgayketThucCungCap date,
SoLuongXeDangKy int,
foreign key (DK_MaNhaCC) references NhaCungCap(MaNhaCC),
foreign key (DK_MaLoaiDV) references DichVu(MaLoaiDV),
foreign key (Dk_DongXe) references Dongxe(DongXe),
foreign key (DK_MaMP) references MucPhi(MaMP)
);



/*Câu 3: Liệt kê những dòng xe có số chỗ ngồi trên 5 chỗ*/
select DongXe,HangXe
from Dongxe
where SoChoNgoi >5;

/*4 Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp những dòng xe thuộc hãng xe “Toyota” với mức phí có đơn giá là 15.000 VNĐ/km hoặc những dòng xe
thuộc hãng xe “KIA” với mức phí có đơn giá là 20.000 VNĐ/km
*/
select TenNhaCC,DongXe
from NhaCungCap
join DangKyCungCap on DangKyCungCap.DK_MaNhaCC = NhaCungCap.MaNhaCC
join Dongxe on DangKyCungCap.DK_DongXe = Dongxe.DongXe
join MucPhi on DangKyCungCap.DK_MaMP = MucPhi.MaMP
where (TenNhaCC like 'Toyota%' and DonGia = 15000) or(TenNhaCC like 'KIA%' and DonGia = 20000);
/*5  Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên nhà cung
cấp và giảm dần theo mã số thuế
*/

select TenNhaCC,MaSoThue
from NhaCungCap
order by  MaSoThue asc , TenNhaCC desc;


/*6 Đếm số lần đăng ký cung cấp phương tiện tương ứng cho từng nhà cung cấp với
yêu cầu chỉ đếm cho những nhà cung cấp thực hiện đăng ký cung cấp có ngày bắt đầu
cung cấp là “2021-07-19”
*/

select count(TenNhaCC) as 'số lần đăng ký',TenNhaCC,NgayBatDauCungCap
from NhaCungCap
join DangKyCungCap on DangKyCungCap.DK_MaNhaCC = NhaCungCap.MaNhaCC
where NgayBatDauCungCap like '2021-07-19%';

/*7 Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe
chỉ được liệt kê một lần
*/

select distinct HangXe
from Dongxe;

/*8 Liệt kê MaDKCC, MaNhaCC, TenNhaCC, DiaChi, MaSoThue, TenLoaiDV, DonGia,
HangXe, NgayBatDauCC, NgayKetThucCC của tất cả các lần đăng ký cung cấp phương
tiện với yêu cầu những nhà cung cấp nào chưa từng thực hiện đăng ký cung cấp phương
tiện thì cũng liệt kê thông tin những nhà cung cấp đó ra
*/ 
select MaDKCC,MaNhaCC,TenNhaCC,DiaChi,MaSoThue,TenLoaiDV,DonGia,HangXe,NgayBatDauCungCap,NgayketThucCungCap
from NhaCungCap
join DangKyCungCap on DangKyCungCap.DK_MaNhaCC = NhaCungCap.MaNhaCC
join Dongxe on DangKyCungCap.DK_DongXe = Dongxe.DongXe
join MucPhi on DangKyCungCap.DK_MaMP = MucPhi.MaMP
join DichVu on DangKyCungCap.DK_MaLoaiDV = DichVu.MaLoaiDV
where SoLuongXeDangKy >=0;

/*9  Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp phương tiện
thuộc dòng xe “Hiace” hoặc từng đăng ký cung cấp phương tiện thuộc dòng xe “Cerato”
*/
select NhaCungCap.*,DongXe,SoLuongXeDangKy
from NhaCungCap
join DangKyCungCap on DangKyCungCap.DK_MaNhaCC = NhaCungCap.MaNhaCC
join Dongxe on DangKyCungCap.DK_DongXe = Dongxe.DongXe
where (HangXe like 'Hiace%' and SoLuongXeDangKy>0) or (HangXe like 'Cerato%' and SoLuongXeDangKy>0);

/*10 Liệt kê thông tin của các nhà cung cấp chưa từng thực hiện đăng ký cung cấp
phương tiện lần nào cả.
*/
select NhaCungCap.*,DongXe,SoLuongXeDangKy
from NhaCungCap
join DangKyCungCap on DangKyCungCap.DK_MaNhaCC = NhaCungCap.MaNhaCC
join Dongxe on DangKyCungCap.DK_DongXe = Dongxe.DongXe
where SoLuongXeDangKy=0;