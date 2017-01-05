/* 
This is project of Dealer Database System.
Created by Ricko Virnanda & Muhammad Fariz Syakur A
On Esa Unggul University
Date Created 04 Jan 2017
Make for Oracle Database environment
Using SQL(Structured Query Languange) for Structured code sintax 
*/


/*
*  Data Definition Language (DDL) start here 
*/

-- membuat tabel untuk sales
create table sales (
    kode_sales varchar2(10) not null,
    nama_sales varchar2(50) not null,
    password char(100) not null,
    foto char(100) not null,
    primary key(kode_sales)
);

-- membuat table untuk customer
create table customer(
    NIK char(20) not null,
    nama_customer varchar2(30) not null,
    alamat_customer char(150) not null,
    telepon_customer char(25) not null,
    primary key(NIK)
);

-- membuat table untuk tipe mobil
create table tipe(
    kode_tipe varchar2(10) not null,
    nama_tipe varchar2(20) not null,
    primary key(kode_tipe)
);

-- membuat table untuk merek mobil
create table merek(
    kode_merek varchar2(10) not null,
    nama_merek varchar2(20) not null,
    asal_negara varchar2(20) not null,
    primary key(kode_merek)
);

-- membuat table untuk mobil
create table mobil(
    kode_mobil char(10) not null,
    nama_mobil varchar2(20) not null,
    warna varchar2(10) not null,
    harga_mobil number(25) not null,
    deskripsi char(300) not null,
    gambar char(100) not null,
    kode_tipe varchar2(10) not null,
    kode_merek varchar2(10) not null,
    primary key(kode_mobil),
    foreign key(kode_tipe) references tipe(kode_tipe),
    foreign key(kode_merek) references merek(kode_merek)
);

-- membuat table untuk transaksi
create table transaksi(
    kode_transaksi char(20) not null,
    NIK char(20) not null,
    tgl_transaksi date not null,
    jenis_transaksi char(10) not null,
    foreign key(NIK) references customer(NIK),
    primary key(kode_transaksi)
);

-- membuat table untuk paket kredit
create table paket_kredit(
    kode_paket char(10) not null,
    nama_paket varchar2(50) not null,
    dp number(25) not null,
    biaya_angsuran number(20) not null,
    jumlah_angsuran number(5) not null,
    primary key(kode_paket)
);

-- membuat table untuk cash
create table cash(
    kode_cash char(20) not null,
    harga_cash number(25) not null,
    kode_transaksi char(20) not null,
    primary key(kode_cash),
    foreign key(kode_transaksi) references transaksi(kode_transaksi)
);

-- membuat table untuk kredit
create table kredit(
    kode_kredit char(20) not null,
    kode_transaksi char(20) not null,
    kode_mobil char(10) not null,
    kode_paket char(10) not null,
    fotocopy_ktp varchar2(100) not null,
    fotocopy_kk varchar2(100) not null,
    fotocopy_slip_gaji varchar2(100) not null,
    status_kredit char(20) not null,
    sisa_kredit char(5) not null,
    primary key(kode_kredit),
    foreign key(kode_mobil) references mobil(kode_mobil),
    foreign key(kode_paket) references paket_kredit(kode_paket),
    foreign key(kode_transaksi) references transaksi(kode_transaksi)
);

-- membuat table untuk cicilan
create table cicilan(
    kode_cicilan char(20) not null,
    kode_transaksi char(20) not null,
    cicilan_ke number(5) not null,
    harga_cicilan number(20) not null,
    kode_kredit char(20) not null,
    primary key(kode_cicilan),
    foreign key(kode_transaksi) references transaksi(kode_transaksi),
    foreign key(kode_kredit) references kredit(kode_kredit)
);


/* table belum jelas
create table undian(
    NIK char(20) not null,
    kode_mobil char(10) not null,
    foreign key(NIK) references customer(NIK),
    foreign key(kode_mobil) references mobil(kode_mobil),
    primary key(NIK, kode_mobil)
);

create table cust_harian_peluang(
    NIK char(20) not null,
    hari char(20) not null,
    foreign key(NIK) references customer(NIK),
    primary key(NIK,hari)
);


create table sales_merek_bonus(
    kode_sales char(5) not null,
    kode_merek varchar2(10) not null,
    foreign key(kode_sales) references sales(kode_sales),
    foreign key(kode_merek) references merek(kode_merek),
    primary key(kode_sales, kode_merek)
);

create table sales_mobil_bonus(
    kode_sales char(5) not null,
    kode_mobil char(10) not null,
    foreign key(kode_sales) references sales(kode_sales),
    foreign key(kode_mobil) references mobil(kode_mobil),
    primary key(kode_sales, kode_mobil)
);

create table merek_mobil_bonus(
    kode_merek varchar2(10) not null,
    kode_mobil char(10) not null,
    foreign key(kode_mobil) references mobil(kode_mobil),
    foreign key(kode_merek) references merek(kode_merek),
    primary key(kode_mobil, kode_merek)
);

alter table undian rename to cust_mobil_peluang;

alter table cust_harian_peluang rename to cust_hari_peluang;

*/

-- alter table cicilan untuk menambah column denda pada table cicilan
alter table cicilan add denda number(10) not null;

-- alter table cicilan untuk menambah column jatuh_tempo pada table cicilan
alter table cicilan add jatuh_tempo date not null;

-- alter table cicilan untuk menambah column tanggal_bayar pada table cicilan
alter table cicilan add tanggal_bayar date not null;

-- alter table sales untuk mengubah kolom kode_sales(5)
alter table sales modify kode_sales char(5);

-- alter table kredit untuk menambah kolom tanggal_kredit
alter table kredit add tanggal_kredit date not null;

-- alter table kredit untuk menambah kolom tanggal_cash
alter table cash add tanggal_cash date not null;

-- alter table transaksi untuk menambah kolom kode_sales
alter table transaksi add kode_sales char(5) not null;

-- alter table transaksi untuk menambah foreign key kode_sales
alter table transaksi add foreign key(kode_sales) references sales(kode_sales);

-- alter table cash untuk menambah kolom kode_mobil
alter table cash add kode_mobil char(10) not null;

-- alter table cash untuk menambah foreign key kode_mobil
alter table cash add foreign key(kode_mobil) references mobil(kode_mobil);

-- alter table transaksi untuk menambah kolom total_harga
alter table transaksi add total_harga number(25) not null;

-- alter table cash untuk menghapus kolom harga_cash
alter table cash drop column harga_cash;

-- alter table paket_kredit untuk mengubah kolom dp ke decimal number
alter table paket_kredit modify dp number(7,3);

-- alter table paket_kredit untuk mengubah kolom biaya_angsuran ke decimal number
alter table paket_kredit modify biaya_angsuran number(7,3);

/*
alter table sales_merek_bonus modify kode_sales char(5);

alter table sales_mobil_bonus modify kode_sales char(5);
*/


/*
*  This is end of Data Definition Language (DDL) 
*/


/*
*  Sequence start here 
*/

/*
mengecek sequence
SELECT s_sales.nextVal FROM DUAL;
*/

-- membuat sequence s_sales untuk sales
create sequence s_sales start with 1100;

-- membuat sequence s_transaksi untuk transaksi
create sequence s_transaksi start with 100000;

-- membuat sequence s_cash untuk tabel cash
create sequence s_cash start with 10000;

-- membuat sequence s_kredit untuk tabel kredit
create sequence s_kredit start with 10000;

-- membuat sequence s_cicilan untuk tabel cicilan
create sequence s_cicilan start with 10000;

-- membuat sequence s_mobil untuk tabel mobil
create sequence s_mobil start with 10000;

-- membuat sequence s_tipe untuk tabel tipe
create sequence s_tipe start with 10000;

-- membuat sequence s_merek untuk tabel merek
create sequence s_merek start with 10000;

-- membuat sequence s_paket untuk tabel paket kredit
create sequence s_paket start with 10000;

/*
*  End of Sequence 
*/

/* 
*  Creating store procedure start here 
*/

/* 
*  membuat prosedur count_total_transaksi untuk menambahkan harga ke total_harga pada table transaksi
*  passing parameter kode_transaksi dan harga yang akan ditambahkan
*/
create or replace procedure count_total_transaksi(c_kode_transaksi char, c_harga number)
is
    total_harga number; -- deklarasi variable total_harga tipe data number
    total number; -- deklarasi variable total tipe data number
begin
    -- mengambil total_harga dari transaksi dan memasukkannya ke variabel total_harga
    select 
        transaksi.total_harga into total_harga
    from
        transaksi
    where
        transaksi.kode_transaksi = c_kode_transaksi;
        
    total := total_harga + c_harga; -- menambahkan total_harga dan harga ke variabel total
    
    -- update total harga pada transaksi
    update
        transaksi
    set
        transaksi.total_harga = total
    where
        transaksi.kode_transaksi = c_kode_transaksi;
end;    

/*
-- belum jelas
create or replace procedure in_peluang_cust(c_kode_transaksi char, c_kode_mobil char)
is
    NIK char(20);
    hari char(20);
    tgl_transaksi date;
begin
    select
        transaksi.NIK, transaksi.tgl_transaksi into NIK, tgl_transaksi
    from
        transaksi
    where
        transaksi.kode_transaksi = c_kode_transaksi;
    
    select 
        to_char(to_date(tgl_transaksi,'dd/mm/yyyy'), 'Day') into hari
    from
        dual;
        
    insert into
    cust_hari_peluang
    values
    (
        NIK,
        hari
    );
       
    insert into
    cust_mobil_peluang
    values
    (
        NIK,
        c_kode_mobil
    );
    
end;


-- belum jelas
create or replace procedure up_peluang_cust(c_kode_transaksi char, c_kode_mobil char)
is
    NIK char(20);
begin
    select
        transaksi.NIK into NIK
    from
        transaksi
    where
        transaksi.kode_transaksi = c_kode_transaksi;
    
    update
        cust_mobil_peluang
    set 
        cust_mobil_peluang.kode_mobil = c_kode_mobil
    where
        cust_mobil_peluang.NIK = NIK;    
end;


-- belum jelas
create or replace procedure dl_peluang_cust(c_kode_transaksi char, c_kode_mobil char)
is
    NIK char(20);
    hari char(20);
    tgl_transaksi date;
begin
    select
        transaksi.NIK, transaksi.tgl_transaksi into NIK, tgl_transaksi
    from
        transaksi
    where
        transaksi.kode_transaksi = c_kode_transaksi;
    
    select 
        to_char(to_date(tgl_transaksi,'dd/mm/yyyy'), 'Day') into hari
    from
        dual;
        
    delete
    from
        cust_hari_peluang
    where
        cust_hari_peluang.NIK = NIK
    and
        cust_hari_peluang.hari = hari;    
        
    delete
    from
        cust_mobil_peluang
    where
        cust_mobil_peluang.NIK = NIK
    and
        cust_mobil_peluang.kode_mobil = c_kode_mobil;   
end;



-- belum jelas
create or replace procedure in_bonus_sales(c_kode_transaksi char, c_kode_mobil char)
is
    kode_sales char(5);
    kode_merek varchar2(10);
begin
    select
        transaksi.kode_sales into kode_sales
    from
        transaksi
    where
        transaksi.kode_transaksi = c_kode_transaksi;
    
    select
        mobil.kode_merek into kode_merek
    from
        mobil
    where
        mobil.kode_mobil = c_kode_mobil;
        
    insert into
    sales_merek_bonus
    values
    (
        kode_sales,
        kode_merek
    );
    
    insert into
    sales_mobil_bonus
    values
    (
        kode_sales,
        c_kode_mobil
    );
    
    insert into
    merek_mobil_bonus
    values
    (
        kode_merek,
        c_kode_mobil
    );
end;


-- belum jelas
create or replace procedure up_bonus_sales(c_kode_transaksi char, c_kode_mobil char, old_kode_mobil char)
is
    kode_sales char(5);
    kode_merek char(10);
    old_kode_merek char(10);
begin
    select
        transaksi.kode_sales into kode_sales
    from
        transaksi
    where
        transaksi.kode_transaksi = c_kode_transaksi;
    
    select
        mobil.kode_merek into kode_merek
    from
        mobil
    where
        mobil.kode_mobil = c_kode_mobil;
    
    select
        mobil.kode_merek into old_kode_merek
    from
        mobil
    where
        mobil.kode_mobil = old_kode_mobil;
    
    update
        sales_merek_bonus
    set 
        sales_merek_bonus.kode_merek = kode_merek
    where
        sales_merek_bonus.kode_sales = kode_sales;    
        
    update
        sales_mobil_bonus
    set 
        sales_mobil_bonus.kode_mobil = kode_mobil
    where
        sales_mobil_bonus.kode_sales = kode_sales
    ;  
    
    delete
    from
        merek_mobil_bonus
    where
        merek_MOBIL_BONUS.KODE_MOBIL = old_kode_mobil
    and
        merek_MOBIL_BONUS.KODE_MEREK = old_kode_merek
    ;
    
    insert into
    merek_mobil_bonus
    values
    (
        kode_merek,
        c_kode_mobil
    );
end;


-- belum jelas
create or replace procedure dl_bonus_sales(c_kode_transaksi char, c_kode_mobil char)
is
    kode_sales char(5);
    kode_merek char(10);
begin
    select
        transaksi.kode_sales into kode_sales
    from
        transaksi
    where
        transaksi.kode_transaksi = c_kode_transaksi;
    
    select
        mobil.kode_merek into kode_merek
    from
        mobil
    where
        mobil.kode_mobil = c_kode_mobil;
    
    delete
    from
        sales_merek_bonus
    where
        sales_merek_BONUS.KODE_sales = kode_sales
    and
        sales_merek_BONUS.KODE_MEREK = kode_merek
    ;
    
    delete
    from
        sales_mobil_bonus
    where
        sales_MOBIL_BONUS.KODE_sales = kode_sales
    and
        sales_MOBIL_BONUS.KODE_mobil = c_kode_mobil
    ;
    
    delete
    from
        merek_mobil_bonus
    where
        merek_MOBIL_BONUS.KODE_MOBIL = c_kode_mobil
    and
        merek_MOBIL_BONUS.KODE_MEREK = kode_merek
    ;
end;
*/

/* 
*  membuat prosedur hitung_transaksi untuk menghitung dan menjumlahkan seluruh harga 
*  yang menggunakan kode_transaksi tertentu
*/
create or replace procedure hitung_transaksi(kode_transaksi char)
is
    total number; -- deklarasi variabel total
begin
    -- menjumlahkan harga dari kredit, cash, dan cicilan ke variabel total
    total := total_kredit_pertransaksi(kode_transaksi) + total_cash_pertransaksi(kode_transaksi) + total_cicilan_pertransaksi(kode_transaksi);
    -- menambahkan total ke dalam total_harga ditable transaksi
    count_total_transaksi(kode_transaksi, total);
end;


/* 
*  membuat fungsi find_angsuran untuk mencari besar harga angsuran dari persen angsuran dikali harga mobil
*  menggunakan dari kode_kredit tertentu
*/
create or replace function find_angsuran(c_kode_kredit char)
return number -- mengembalikan kembalian berupa number
is
    -- deklarasi variabel yang dibutuhkan
    angsuran number;
    harga_mobil number;
    total number;
    c_kode_paket char(10); -- untuk menampung kode_paket
    c_kode_mobil char(10); -- untuk menampung kode_mobil
begin
    -- mencari kode_paket, kode_mobil dari tabel kredit dan kode_kredit tertentu
    select
        kredit.kode_paket,kredit.kode_mobil into c_kode_paket, c_kode_mobil
    from
    kredit
    where
        kredit.kode_kredit = c_kode_kredit;
        
    -- mencari biaya_angsuran dari paket_kredit berdasarkan kode_paket dari table kredit
    select 
        paket_kredit.biaya_angsuran into angsuran
    from
        paket_kredit 
    where 
        paket_kredit.kode_paket = c_kode_paket;
    
    -- mencari harga mobil dari mobil berdasarkan kode_mobil dari table kredit
    select
        mobil.harga_mobil into harga_mobil
    from
        mobil
    where 
        mobil.kode_mobil = c_kode_mobil;
    
    -- mengalikan besar angsuran * harga mobil
    total := angsuran*harga_mobil;
    return total; -- keluaran yang dihasilkan
end;


/* 
*  membuat fungsi find_dp untuk mencari besar harga dp dari persen dp dikali harga mobil
*  menggunakan dari kode_kredit tertentu
*/
create or replace function find_dp(c_kode_kredit char)
return number  -- mengembalikan kembalian berupa number
is
    dp number;
    harga_mobil number;
    total number;
    c_kode_paket char(10); -- untuk menampung kode_paket
    c_kode_mobil char(10); -- untuk menampung kode_mobil
begin
    -- mencari kode_paket, kode_mobil dari tabel kredit dan kode_kredit tertentu
    select
        kredit.kode_paket,kredit.kode_mobil into c_kode_paket, c_kode_mobil
    from
    kredit
    where
        kredit.kode_kredit = c_kode_kredit;
        
    -- mencari dp dari paket_kredit berdasarkan kode_paket dari table kredit
    select 
        paket_kredit.dp into dp
    from
        paket_kredit 
    where 
        paket_kredit.kode_paket = c_kode_paket;
        
    -- mencari harga mobil dari mobil berdasarkan kode_mobil dari table kredit
    select
        mobil.harga_mobil into harga_mobil
    from
        mobil
    where 
        mobil.kode_mobil = c_kode_mobil;
    -- mengalikan besar angsuran * harga mobil
    total := dp*harga_mobil;
    return total; -- keluaran yang dihasilkan
end;


/* 
*  membuat fungsi find_h_mobil untuk mencari harga mobil
*  menggunakan dari kode_mobil tertentu
*/
create or replace function find_h_mobil(c_kode_mobil char)
return number -- keluaran berupa number
is
    harga_mobil number;
    total number;
begin
    -- mencari harga_mobil berdasarkan kode_mobil
    select 
        mobil.harga_mobil into harga_mobil 
    from
        mobil 
    where 
        kode_mobil = c_kode_mobil;
    total := harga_mobil;
    
    return total;
end;


/* 
*  membuat fungsi total_cash_pertransaksi untuk menghitung seluruh harga cash pembelian mobil
*  pertransaksi yang telah dilakukan
*  menggunakan dari kode_transaksi tertentu
*/
create or replace function total_cash_pertransaksi(kode_transaksi char)
return number -- keluaran berupa number
is
    total number; -- deklarasi variabel total
    -- membuat cursor c1 untuk menampung data kode mobil dari table cash pada transaksi tertentu
    cursor c1 is
        select
            cash.kode_mobil
        from
            cash
        where
            cash.kode_transaksi = kode_transaksi;
begin
    -- mengeset total adalah 0 untuk nantinya menampung data operasi penjumlahan seluruh harga
    total := 0;
    -- looping untuk mengurai cursor c1 dan cash_fetch mengambil data dari c1 kemudian diuraikan
    for cash_fetch in c1
    loop
        total := total + find_h_mobil(cash_fetch.kode_mobil); -- menghitung total harga cash mobil
    end loop;
    return total; -- mengembalikan keluaran dari total
end;


/* 
*  membuat fungsi total_kredit_pertransaksi untuk menghitung seluruh harga kredit pembelian mobil
*  pertransaksi yang telah dilakukan
*  menggunakan dari kode_transaksi tertentu
*/
create or replace function total_kredit_pertransaksi(kode_transaksi char)
return number -- keluaran berupa number
is
    total number; -- deklarasi variabel total
    -- membuat cursor c1 untuk menampung data kode_kredit dari table kredit pada transaksi tertentu
    cursor c1 is
        select
            kredit.kode_kredit
        from
            kredit
        where
            kredit.kode_transaksi = kode_transaksi;
begin
    -- mengeset total adalah 0 untuk nantinya menampung data operasi penjumlahan seluruh harga
    total := 0;
    -- looping untuk mengurai cursor c1 dan kredit_fetch mengambil data dari c1 kemudian diuraikan
    for kredit_fetch in c1
    loop
        total := total + find_dp(kredit_fetch.kode_kredit);-- menghitung total harga dp mobil
    end loop;
    return total; -- mengembalikan keluaran dari total
end;


/* 
*  membuat fungsi total_cicilan_pertransaksi untuk menghitung seluruh harga cicilan mobil
*  pertransaksi yang telah dilakukan
*  menggunakan dari kode_transaksi tertentu
*/
create or replace function total_cicilan_pertransaksi(kode_transaksi char)
return number -- keluaran berupa number
is
    total number; -- deklarasi variabel total
    -- membuat cursor c1 untuk menampung data kode_kredit dari table cicilan pada transaksi tertentu
    cursor c1 is
        select
            cicilan.kode_kredit
        from
            cicilan
        where
            cicilan.kode_transaksi = kode_transaksi;
begin
    -- mengeset total adalah 0 untuk nantinya menampung data operasi penjumlahan seluruh harga
    total := 0;
    -- looping untuk mengurai cursor c1 dan cicilan_fetch mengambil data dari c1 kemudian diuraikan
    for cicilan_fetch in c1
    loop
        total := total + find_angsuran(cicilan_fetch.kode_kredit);-- menghitung total harga angsuran mobil
    end loop;
    return total; -- mengembalikan keluaran dari total
end;

/* 
*  End of store procedure
*/


/* 
*  Creating trigger start here 
*/

/*
*  membuat trigger uk_sales before insert untuk unik kode_sales
*/
create or replace trigger uk_sales
    before insert on sales
    for each row
begin
    -- menambahkan karakter 'P' diawal kode_sales pada setiap kode_sales yang baru
    :new.kode_sales := 'P'||trim(to_char(:new.kode_sales));
end;


/*
*  membuat trigger uk_transaksi before insert untuk unik kode_transaksi dan operasi operasi otomatis saat di insert
*/
create or replace trigger uk_transaksi
    before insert on transaksi
    for each row
begin
    -- menambahkan karakter 'TRX' diawal kode_transaksi pada setiap kode_transaksi yang baru
    :new.kode_transaksi := 'TRX'||trim(to_char (:new.kode_transaksi));
    :new.total_harga := 0; -- total_harga karena tidak diisi pada operasi DML maka diset 0 untuk operasi dengan prosedur
end;


/*
*  membuat trigger uk_cash before insert untuk unik kode_cash dan operasi operasi otomatis saat di insert
*/
create or replace trigger uk_cash
    before insert on cash
    for each row
    declare
    tgl date; -- deklarasi variabel tgl untuk menampung tanggal_transaksi
begin
    -- menambahkan karakter 'BCS' diawal kode_cash pada setiap kode_cash yang baru
    :new.kode_cash := 'BCS'||trim(to_char (:new.kode_cash));
    -- mencari tanggal transaksi dari data kode_transaksi yang baru di input table cash dan dimasukkan ke variabel tgl
    select
        transaksi.TGL_TRANSAKSI into tgl
    from
        transaksi
    where
        transaksi.kode_transaksi = :new.kode_transaksi;
    -- mengeset tanggal cash dari variabel tgl dari tanggal transaksi
    :new.tanggal_cash := tgl;
end;
-- perubahan baru sampai sini silahkan commit ke database

create or replace trigger uk_kredit
    before insert on kredit
    for each row
    declare
    sisa_kredit number;
    tgl date;
begin
    :new.kode_kredit := 'BKR'||trim(to_char (:new.kode_kredit));
    
    select
        paket_kredit.jumlah_angsuran into sisa_kredit
    from
        paket_kredit
    where
        paket_kredit.kode_paket = :new.kode_paket;
        
    :new.sisa_kredit := sisa_kredit;
    
    select
        transaksi.TGL_TRANSAKSI into tgl
    from
        transaksi
    where
        transaksi.kode_transaksi = :new.kode_transaksi;
    
    :new.tanggal_kredit := tgl;
    :new.status_kredit := 'belum lunas';
        
    :new.fotocopy_kk := trim(to_char (:new.kode_kredit))||'_fc_kk.jpg';
    :new.fotocopy_ktp := trim(to_char (:new.kode_kredit))||'_fc_ktp.jpg';
    :new.fotocopy_slip_gaji := trim(to_char (:new.kode_kredit))||'_fc_slg.jpg';
end;


create or replace trigger uk_cicilan
    before insert on cicilan
    for each row
    declare
    jumlah_angsuran number;
    sisa_kredit number;
    cicilan_ke number;
    jatuh_tempo date;
    tanggal_bayar date;
    tanggal_kredit date;
    selisih_bulan number;
    denda number;
    
    cursor cukre is
        select
        kredit.kode_paket, kredit.sisa_kredit, kredit.tanggal_kredit  
        from
            kredit
        where
            kredit.kode_kredit = :new.kode_kredit;
    
begin
    :new.kode_cicilan := 'CCL'||trim(to_char (:new.kode_cicilan));
    :new.harga_cicilan := find_angsuran(:new.kode_kredit);
    denda :=0;
    
    for kredit_fetch in cukre
    loop
        select
            paket_kredit.jumlah_angsuran into jumlah_angsuran
        from
            paket_kredit
        where
            paket_kredit.kode_paket = kredit_fetch.kode_paket;
            
        sisa_kredit := kredit_fetch.sisa_kredit;
        tanggal_kredit := kredit_fetch.tanggal_kredit;
    end loop;
    cicilan_ke := jumlah_angsuran-sisa_kredit+1;
    jatuh_tempo := add_months(tanggal_kredit,cicilan_ke);
    
    update
        kredit
    set
        kredit.sisa_kredit = sisa_kredit-1
    where
        kredit.kode_kredit = :new.kode_kredit;
    
    select
        transaksi.tgl_transaksi into tanggal_bayar
    from
        transaksi
    where
        transaksi.kode_transaksi = :new.kode_transaksi;
        
    if sisa_kredit <= 1 then
    update
        kredit
    set
        kredit.status_kredit = 'lunas'
    where
        kredit.kode_kredit = :new.kode_kredit;
    
    end if;

    selisih_bulan := months_between(tanggal_bayar, jatuh_tempo);
    if selisih_bulan > 0 then
        denda := find_angsuran(:new.kode_kredit)*0.05;
    end if;
    :new.denda := denda;
    :new.tanggal_bayar := tanggal_bayar;
    :new.jatuh_tempo := jatuh_tempo;
    :new.cicilan_ke := cicilan_ke;
end;



create or replace trigger uk_merek
    before insert on merek
    for each row
begin
    :new.kode_merek := 'MRK'||trim(to_char (:new.kode_merek));
end;


create or replace trigger uk_tipe
    before insert on tipe
    for each row
begin
    :new.kode_tipe := 'T'||trim(to_char (:new.kode_tipe));
end;


create or replace trigger uk_mobil
    before insert on mobil
    for each row
    declare
        sub_merek char(3);
begin
    select 
        upper(substr(merek.nama_merek,0,3)) 
        into 
        sub_merek 
    from
        merek 
    where 
        merek.kode_merek = :new.kode_merek;
        
    :new.kode_mobil := sub_merek||trim(to_char (:new.kode_mobil));
    :new.gambar := trim(to_char (:new.kode_mobil))||'_pic.jpg';
end;


create or replace trigger uk_paket
    before insert on paket_kredit
    for each row
begin
    :new.kode_paket := 'PKT'||trim(to_char (:new.kode_paket));
end;


create or replace trigger del_transaksi
    before delete on transaksi
    for each row
begin
    delete from cicilan where cicilan.kode_transaksi = :old.kode_transaksi;
    delete from cash where cash.kode_transaksi = :old.kode_transaksi;
    delete from kredit where kredit.kode_transaksi = :old.kode_transaksi;
end;


drop trigger UP_ACT_KREDIT;
drop trigger UP_ACT_CASH;

/*
create or replace trigger otosum_in_cash_transkasi
    after insert on cash
    for each row
begin  
    count_total_transaksi(:new.kode_transaksi, find_h_mobil(:new.kode_mobil));
end;


create or replace trigger otosum_up_cash_transkasi
    after update on cash
    for each row
    declare 
    h_lama number;
    h_baru number;
    hitung number;
begin  
    h_lama := find_h_mobil(:old.kode_mobil);
    h_baru := find_h_mobil(:new.kode_mobil);
    hitung := h_baru - h_lama;
    count_total_transaksi(:new.kode_transaksi, hitung);
end;

create or replace trigger otosum_dl_cash_transkasi
    before delete on cash
    for each row
    declare 
    h_lama number;
    hitung number;
begin  
    h_lama := find_h_mobil(:old.kode_mobil);
    hitung := h_lama*(-1);
    count_total_transaksi(:new.kode_transaksi, hitung);
end;


create or replace trigger otosum_in_kredit_transkasi
    after insert on kredit
    for each row
begin  
    count_total_transaksi(:new.kode_transaksi, find_h_mobil(:new.kode_mobil));
end;


create or replace trigger otosum_up_kredit_transkasi
    after update on kredit
    for each row
    declare 
    dp_lama number;
    dp_baru number;
    hitung number;
begin  
    dp_lama := find_dp(:old.kode_paket,:old.kode_mobil);
    dp_baru := find_dp(:new.kode_paket,:new.kode_mobil);
    hitung := dp_baru - dp_lama;
    count_total_transaksi(:new.kode_transaksi, hitung);
end;


create or replace trigger otosum_dl_kredit_transkasi
    before delete on kredit
    for each row
    declare 
    dp_lama number;
    hitung number;
begin  
    dp_lama := find_dp(:old.kode_paket,:old.kode_mobil);
    hitung := dp_lama*(-1);
    count_total_transaksi(:new.kode_transaksi, hitung);
end;

drop trigger otosum_dl_kredit_transkasi;
drop trigger otosum_up_kredit_transkasi;
drop trigger otosum_in_kredit_transkasi;
drop trigger otosum_dl_cash_transkasi;
drop trigger otosum_up_cash_transkasi;
drop trigger otosum_in_cash_transkasi;

*/
/* end of triggers */


insert into merek
values(
s_merek.nextVal,
'Honda',
'Jepang'
);

insert into merek
values(
s_merek.nextVal,
'Suzuki',
'Jepang'
);

insert into tipe
values(
s_tipe.nextVal,
'MPV'
);

select * from mobil;

update
    mobil
set
    mobil.nama_mobil = 'dudung'
where
    mobil.kode_mobil = 'HON10019';

insert into mobil
values(
s_mobil.nextVal,
'Teses',
'Hijau',
'100000000',
'keren nih',
'tes.jpg',
'T10000',
'MRK10000'
);

insert into sales
values(
s_sales.nextVal,
'Salim',
'salimin',
'salimsalam.jpg'
);

insert into customer
values(
'4654543254543',
'ricko',
'jalan. jalan kepasar',
'089674869559'
);

insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales,
total_harga
)
values(
s_transaksi.nextVal,
'4654543254543',
to_date(sysdate,'dd/mm/yyyy'),
'tunai',
'P1107',
'0'
);

insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket,
status_kredit
)
values(
s_kredit.nextVal,
'TRX100040',
'HON10019',
'PKT10002',
'belum lunas'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100040',
'BKR10001'
);

insert into paket_kredit
(
kode_paket,
nama_paket,
dp,
biaya_angsuran,
jumlah_angsuran
)
values(
s_paket.nextVal,
'2 tahun cicilan',
'0.5',
'3.958',
'24'
);

insert into cash
(
kode_cash,
kode_transaksi,
kode_mobil
)
values
(
s_cash.nextVal,
'TRX100040',
'HON10019'
);

select CURRENT_TIME from dual;

delete from transaksi;

delete from paket_kredit;

select * from cicilan;
select * from kredit;
select * from cust_mobil_peluang;
select * from sales_mobil_bonus;
select * from merek_mobil_bonus;
select * from sales_merek_bonus;
select * from cust_hari_peluang;
select * from cash;
select * from transaksi;
select * from paket_kredit;
select * from mobil;
select * from merek;
select * from tipe;
select * from sales;
select * from customer;


select * from sales;
exec count_total_transaksi('TRX100040',total_cicilan_pertransaksi('TRX100040'));
exec DBMS_OUTPUT.PUT_LINE(find_angsuran('BKR10041'));

exec find_angsuran('BKR10001');
/*SELECT A DAY 
select to_char(to_date(SYSDAT,'dd/mm/yyyy'), 'Day') FROM dual

*/
/*RANDOM SELECT 
select * from (
select NIK from customer where kode_sales = '10003' order by dbms_random.value)
where rownum = 1
*/

/*============== DML START HERE=============== */


/* insert sales */
insert into 
sales
(kode_sales,
nama_sales,
password,
foto)
values
(
s_sales.nextVal,
'mamang',
'4lAy',
'gantengs.jpg'
);

insert into 
sales
(kode_sales,
nama_sales,
password,
foto)
values
(
s_sales.nextVal,
'Dimas',
'Doszx',
'doszx.jpg'
);


insert into 
sales
(kode_sales,
nama_sales,
password,
foto)
values
(
s_sales.nextVal,
'Salim',
'S4lIms',
'Salimin.jpg'
);


insert into 
sales
(kode_sales,
nama_sales,
password,
foto)
values
(
s_sales.nextVal,
'Zaid',
'zAiD',
'Zaidunsaleh.jpg'
);


insert into 
sales
(kode_sales,
nama_sales,
password,
foto)
values
(
s_sales.nextVal,
'Ahmad',
'AHMAD',
'ahmadun.jpg'
);

/* insert customer */
insert into 
customer
(NIK,
nama_customer,
alamat_customer,
telepon_customer)
values
(
'54564644454212',
'danang',
'jalan jalan',
'0856475812'
);

insert into 
customer
(NIK,
nama_customer,
alamat_customer,
telepon_customer)
values
(
'11155678437623',
'Mansurun',
'jalan selamat no 3',
'08882377888'
);


insert into 
customer
(NIK,
nama_customer,
alamat_customer,
telepon_customer)
values
(
'9375338474827',
'Zainabun',
'jalan sabun mandi no 3',
'08977666237'
);


insert into 
customer
(NIK,
nama_customer,
alamat_customer,
telepon_customer)
values
(
'9095123928381',
'tia',
'jalan sejahtera no 4',
'089773455522'
);


insert into 
customer
(NIK,
nama_customer,
alamat_customer,
telepon_customer)
values
(
'2015318923823',
'lilis',
'jalan arjuna no 4',
'08977348787'
);


insert into 
customer
(NIK,
nama_customer,
alamat_customer,
telepon_customer)
values
(
'9493481115834848',
'mety lasmana',
'jalan h sanuni no 4',
'082214369905'
);


insert into 
customer
(NIK,
nama_customer,
alamat_customer,
telepon_customer)
values
(
'11122233344455',
'dina rafikah',
'jalan quwito no 4',
'082214399999'
);

/* insert tipe */
insert into 
tipe
(kode_tipe,
nama_tipe)
values
(
s_tipe.nextVal,
'Sport'
);


insert into 
tipe
(kode_tipe,
nama_tipe)
values
(
s_tipe.nextVal,
'Sedan'
);


insert into 
tipe
(kode_tipe,
nama_tipe)
values
(
s_tipe.nextVal,
'mobil kota'
);


insert into 
tipe
(kode_tipe,
nama_tipe)
values
(
s_tipe.nextVal,
'super mini'
);


insert into 
tipe
(kode_tipe,
nama_tipe)
values
(
s_tipe.nextVal,
'SUV'
);

insert into 
tipe
(kode_tipe,
nama_tipe)
values
(
s_tipe.nextVal,
'convertible'
);

/* insert merek */
insert into 
merek
(kode_merek,
nama_merek,
asal_negara)
values
(
s_merek.nextVal,
'mitsubishi',
'jepang'
);


insert into 
merek
(kode_merek,
nama_merek,
asal_negara)
values
(
s_merek.nextVal,
'honda',
'jepang'
);


insert into 
merek
(kode_merek,
nama_merek,
asal_negara)
values
(
s_merek.nextVal,
'toyota',
'jepang'
);


insert into 
merek
(kode_merek,
nama_merek,
asal_negara)
values
(
s_merek.nextVal,
'ford',
'amerika'
);



insert into 
merek
(kode_merek,
nama_merek,
asal_negara)
values
(
s_merek.nextVal,
'suzuki',
'jepang'
);


/* insert paket_kredit */
insert into 
paket_kredit
(kode_paket,
nama_paket,
dp,
biaya_angsuran,
jumlah_angsuran)
values
(
s_paket.nextVal,
'12 bulan jadi',
0.05,
0.075,
12
);


insert into 
paket_kredit
(kode_paket,
nama_paket,
dp,
biaya_angsuran,
jumlah_angsuran)
values
(
s_paket.nextVal,
'alhamdulillah 9 bulan',
0.05,
0.105,
9
);


insert into 
paket_kredit
(kode_paket,
nama_paket,
dp,
biaya_angsuran,
jumlah_angsuran)
values
(
s_paket.nextVal,
'hemat 24 bulan',
0.05,
0.04,
24
);


insert into 
paket_kredit
(kode_paket,
nama_paket,
dp,
biaya_angsuran,
jumlah_angsuran)
values
(
s_paket.nextVal,
'mantap 36 bulan',
0.05,
0.0264,
36
);

/* insert mobil */
insert into mobil
(
kode_mobil,
nama_mobil,
warna,
harga_mobil,
deskripsi,
kode_tipe,
kode_merek
)
values(
s_mobil.nextVal,
'ABXCP',
'Hijau',
'100000000',
'keren nih',
'T10000',
'MRK10000'
);


insert into mobil
(
kode_mobil,
nama_mobil,
warna,
harga_mobil,
deskripsi,
kode_tipe,
kode_merek
)
values(
s_mobil.nextVal,
'Avansa',
'Hijau',
'100000000',
'keren nih',
'T10000',
'MRK10000'
);


insert into mobil
(
kode_mobil,
nama_mobil,
warna,
harga_mobil,
deskripsi,
kode_tipe,
kode_merek
)
values(
s_mobil.nextVal,
'Avord',
'Hijau',
'100000000',
'keren nih',
'T10020',
'MRK10020'
);


insert into mobil
(
kode_mobil,
nama_mobil,
warna,
harga_mobil,
deskripsi,
kode_tipe,
kode_merek
)
values(
s_mobil.nextVal,
'Camry',
'Hitam',
'138900000',
'mobil sedan anda',
'T10020',
'MRK10021'
);


insert into mobil
(
kode_mobil,
nama_mobil,
warna,
harga_mobil,
deskripsi,
kode_tipe,
kode_merek
)
values(
s_mobil.nextVal,
'Ford Ka',
'Merah',
'255900000',
'City car terbaik manuver kuat berkualitas',
'T10021',
'MRK10022'
);


insert into mobil
(
kode_mobil,
nama_mobil,
warna,
harga_mobil,
deskripsi,
kode_tipe,
kode_merek
)
values(
s_mobil.nextVal,
'Lancer Evolution',
'Abu-abu',
'235900000',
'Mobil sport berkualitas',
'T10000',
'MRK10000'
);


insert into mobil
(
kode_mobil,
nama_mobil,
warna,
harga_mobil,
deskripsi,
kode_tipe,
kode_merek
)
values(
s_mobil.nextVal,
'Suzuki Cervo',
'Putih',
'135900000',
'to be a most car in the city',
'T10023',
'MRK10021'
);

/* insert transaksi */
insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'11155678437623',
to_date('12/05/2015','dd/mm/yyyy'),
'tunai',
'P1122'
);


insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'9375338474827',
to_date('11/11/2016','dd/mm/yyyy'),
'tunai',
'P1123'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'9095123928381       ',
to_date('09/01/2016','dd/mm/yyyy'),
'tunai',
'P1122'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'09493487475834848   ',
to_date('22/07/2016','dd/mm/yyyy'),
'tunai',
'P1100'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'11122233344455      ',
to_date('17/05/2015','dd/mm/yyyy'),
'tunai',
'P1120'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'54564644454212      ',
to_date('19/05/2016','dd/mm/yyyy'),
'tunai',
'P1122'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'11155678437623',
to_date('12/07/2015','dd/mm/yyyy'),
'tunai',
'P1122'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'2015318923823       ',
to_date('12/05/2015','dd/mm/yyyy'),
'tunai',
'P1120'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'11122233344455      ',
to_date('10/02/2016','dd/mm/yyyy'),
'tunai',
'P1123'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'9095123928381       ',
to_date('12/07/2016','dd/mm/yyyy'),
'tunai',
'P1121'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'9375338474827       ',
to_date('12/05/2015','dd/mm/yyyy'),
'tunai',
'P1120'
);

insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'11155678437623',
to_date('12/07/2015','dd/mm/yyyy'),
'tunai',
'P1122'
);


-- next

insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'2015318923823       ',
to_date('28/05/2016','dd/mm/yyyy'),
'tunai',
'P1122'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'11122233344455      ',
to_date('10/08/2016','dd/mm/yyyy'),
'tunai',
'P1120'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'9095123928381       ',
to_date('12/04/2016','dd/mm/yyyy'),
'tunai',
'P1120'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'9375338474827       ',
to_date('10/03/2016','dd/mm/yyyy'),
'tunai',
'P1123'
);

-- next

insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'2015318923823       ',
to_date('28/06/2015','dd/mm/yyyy'),
'tunai',
'P1120'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'11122233344455      ',
to_date('10/09/2016','dd/mm/yyyy'),
'tunai',
'P1123'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'9095123928381       ',
to_date('12/07/2016','dd/mm/yyyy'),
'tunai',
'P1121'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'9375338474827       ',
to_date('25/03/2016','dd/mm/yyyy'),
'tunai',
'P1122'
);

insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'2015318923823       ',
to_date('28/10/2016','dd/mm/yyyy'),
'tunai',
'P1121'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'11122233344455      ',
to_date('20/08/2016','dd/mm/yyyy'),
'tunai',
'P1121'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'9095123928381       ',
to_date('12/01/2016','dd/mm/yyyy'),
'tunai',
'P1121'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'9375338474827       ',
to_date('10/01/2016','dd/mm/yyyy'),
'tunai',
'P1120'
);

insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'2015318923823       ',
to_date('28/05/2016','dd/mm/yyyy'),
'tunai',
'P1123'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'11122233344455      ',
to_date('11/09/2016','dd/mm/yyyy'),
'tunai',
'P1122'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'9095123928381       ',
to_date('12/09/2016','dd/mm/yyyy'),
'tunai',
'P1121'
);




insert into transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'9375338474827       ',
to_date('10/11/2016','dd/mm/yyyy'),
'tunai',
'P1121'
);


/* insert kredit */
insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100001',
'MIT10000',
'PKT10003'
);

exec in_bonus_sales('TRX100001','MIT10000');
exec in_peluang_cust('TRX100001','MIT10000');

insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100021',
'TOY10027',
'PKT10020'
);

exec in_bonus_sales('TRX100021','TOY10027');
exec in_peluang_cust('TRX100021','TOY10027');


insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100022',
'MIT10026',
'PKT10022'
);

exec in_bonus_sales('TRX100022','MIT10026');
exec in_peluang_cust('TRX100022','MIT10026');


insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100023',
'FOR10022',
'PKT10021'
);
exec in_bonus_sales('TRX100023','FOR10022');
exec in_peluang_cust('TRX100023','FOR10022');


insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100024',
'TOY10027  ',
'PKT10020'
);

exec in_bonus_sales('TRX100023','TOY10027');
exec in_peluang_cust('TRX100023','TOY10027');

/* insert cicilan */
insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100024',
'BKR10000'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100025',
'BKR10020'
);


insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100026',
'BKR10021'
);


insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100026',
'BKR10022'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100027',
'BKR10022'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100028',
'BKR10023'
);


insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100029',
'BKR10023'
);

/* insert cash */
insert into cash
(
kode_cash,
kode_transaksi,
kode_mobil
)
values
(
s_cash.nextVal,
'TRX100001',
'MIT10000'
);


insert into cash
(
kode_cash,
kode_transaksi,
kode_mobil
)
values
(
s_cash.nextVal,
'TRX100026',
'TOY10027'
);

exec in_bonus_sales('TRX100026','TOY10027');
exec in_peluang_cust('TRX100026','TOY10027');


insert into cash
(
kode_cash,
kode_transaksi,
kode_mobil
)
values
(
s_cash.nextVal,
'TRX100027',
'TOY10021'
);

exec in_bonus_sales('TRX100027','TOY10021');
exec in_peluang_cust('TRX100027','TOY10021');


insert into cash
(
kode_cash,
kode_transaksi,
kode_mobil
)
values
(
s_cash.nextVal,
'TRX100028',
'FOR10022  '
);

exec in_bonus_sales('TRX100028','TOY10022');
exec in_peluang_cust('TRX100028','TOY10022');


insert into cash
(
kode_cash,
kode_transaksi,
kode_mobil
)
values
(
s_cash.nextVal,
'TRX100029',
'FOR10023  '
);

exec in_bonus_sales('TRX100029','FOR10023');
exec in_peluang_cust('TRX100029','FOR10023');


insert into cash
(
kode_cash,
kode_transaksi,
kode_mobil
)
values
(
s_cash.nextVal,
'TRX100030',
'TOY10027  '
);

exec in_bonus_sales('TRX100030','TOY10027');
exec in_peluang_cust('TRX100030','TOY10027');


insert into cash
(
kode_cash,
kode_transaksi,
kode_mobil
)
values
(
s_cash.nextVal,
'TRX100029',
'FOR10022  '
);

exec in_bonus_sales('TRX100029','FOR10022');
exec in_peluang_cust('TRX100029','FOR10022');


insert into cash
(
kode_cash,
kode_transaksi,
kode_mobil
)
values
(
s_cash.nextVal,
'TRX100031',
'TOY10021'
);

exec in_bonus_sales('TRX100031','TOY10021');
exec in_peluang_cust('TRX100031','TOY10021');


exec hitung_transaksi('TRX100001');
select * from transaksi;
exec in_bonus_sales('TRX100001','MIT10000');
exec in_peluang_cust('TRX100001','MIT10000');


create or replace view v_cicilan as select * from cicilan;
create or replace view v_kredit as select * from kredit;
create or replace view v_cust_mobil_peluang as select * from cust_mobil_peluang;
create or replace view v_sales_mobil_bonus as select * from sales_mobil_bonus;
create or replace view v_merek_mobil_bonus as select * from merek_mobil_bonus;
create or replace view v_sales_merek_bonus as select * from sales_merek_bonus;
create or replace view v_cust_hari_peluang as select * from cust_hari_peluang;
create or replace view v_cash as select * from cash;
create or replace view v_transaksi as select * from transaksi;
create or replace view v_paket_kredit as select * from paket_kredit;
create or replace view v_mobil as select * from mobil;
create or replace view v_merek as select * from merek;
create or replace view v_tipe as select * from tipe;
create or replace view v_sales as select * from sales;
create or replace view v_customer as select * from customer;

create or replace view v_trans_pertanggal as select * from transaksi where tgl_transaksi = to_date('12/05/2015','dd/mm/yyyy');

create or replace view v_trans_perbulan as select * from transaksi where tgl_transaksi = to_date('12/05/2015','dd/mm/yyyy');
 
