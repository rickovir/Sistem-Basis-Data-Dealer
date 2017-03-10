/* 
This is project of Dealer Database System.
Created by Ricko Virnanda & Muhammad Fariz Syakur A
On Esa Unggul University
Date Created 04 Jan 2017
Make for Oracle Database environment
Using SQL(Structured Query Languange) for Structured code sintax 


Search keyword :

#1 Data Definition Language (DDL)

#2 Sequence 

#3 Trigger

#4 Store Procedure

#5 Data Manipulation Language (DML)

#6 View

*/


/*
*  =========== #1 Data Definition Language (DDL) start here ===========
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
*  =========== This is end of Data Definition Language (DDL) ===========
*/


/*
*  =========== #2 Sequence start here ===========
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
*  =========== End of Sequence ===========
*/

/* 
*  =========== Store #3 procedure start here ===========
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
*  membuat prosedur hitung_transaksi untuk menghitung dan menjumlahkan seluruh harga 
*  yang menggunakan kode_transaksi tertentu
*/
create or replace procedure hitung_transaksi(kode_transaksi char)
is
    total number; -- deklarasi variabel total
begin
    total :=0;
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
create or replace function total_cash_pertransaksi(trx_kode_transaksi char)
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
            cash.kode_transaksi = trx_kode_transaksi;
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
create or replace function total_kredit_pertransaksi(trx_kode_transaksi char)
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
            kredit.kode_transaksi = trx_kode_transaksi;
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
create or replace function total_cicilan_pertransaksi(trx_kode_transaksi char)
return number -- keluaran berupa number
is
    total number; -- deklarasi variabel total
    -- membuat cursor c1 untuk menampung data kode_kredit dari table cicilan pada transaksi tertentu
    cursor c1 is
        select
            cicilan.kode_kredit, cicilan.harga_cicilan
        from
            cicilan
        where
            cicilan.kode_transaksi = trx_kode_transaksi;
begin
    -- mengeset total adalah 0 untuk nantinya menampung data operasi penjumlahan seluruh harga
    total := 0;
    -- looping untuk mengurai cursor c1 dan cicilan_fetch mengambil data dari c1 kemudian diuraikan
    for cicilan_fetch in c1
    loop
        --total := total + find_angsuran(cicilan_fetch.kode_kredit);-- menghitung total harga angsuran mobil
        total := total + cicilan_fetch.harga_cicilan;-- menghitung total harga cicilan mobil
    end loop;
    return total; -- mengembalikan keluaran dari total
end;


/* 
*  =========== End of store procedure ===========
*/


/* 
*  =========== #4 Trigger start here ===========
*/

/* ------ trigger operasi before insert ------ */

/*
*  membuat trigger uk_sales before insert untuk unik kode_sales
*/
create or replace trigger uk_sales
    before insert on sales
    for each row
begin
    -- menambahkan karakter 'P' diawal kode_sales pada setiap kode_sales yang baru
    :new.kode_sales := 'S'||trim(to_char(:new.kode_sales));
end;


/*
*  membuat trigger uk_transaksi before insert untuk unik kode_transaksi dan set total_harga mulai dari 0
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
*  membuat trigger uk_cash before insert untuk unik kode_cash dan tanggal_cash dari tanggal_transaksi
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


/*
*  membuat trigger uk_kredit before insert untuk unik kode_kredit, mengeset tanggal_kredit, mengeset jumlah angsuran
*  set status kredit dan set gambar fotocopy KTP, KK dan slip gaji
*/
create or replace trigger uk_kredit
    before insert on kredit
    for each row
    declare
    sisa_kredit number;
    tgl date;
begin
    -- menambahkan karakter 'BKR' diawal kode_kredit pada setiap kode_kredit yang baru
    :new.kode_kredit := 'BKR'||trim(to_char (:new.kode_kredit));
    
    -- mencari jumlah angsuran dari paket_kredit yang di pilih table kredit dan dimasukkan ke variabel sisa_kredit
    select
        paket_kredit.jumlah_angsuran into sisa_kredit
    from
        paket_kredit
    where
        paket_kredit.kode_paket = :new.kode_paket;
    

    -- mengeset sisa kredit awal dari jumlah angsuran paket kredit yang dari value variabel sisa_kredit
    :new.sisa_kredit := sisa_kredit;

    
    -- mencari tanggal transaksi dari data kode_transaksi yang di input table kredit dan dimasukkan ke variabel tgl
    select
        transaksi.TGL_TRANSAKSI into tgl
    from
        transaksi
    where
        transaksi.kode_transaksi = :new.kode_transaksi;
    
    -- mengeset tanggal_kredit dari variabel tgl
    :new.tanggal_kredit := tgl;

    -- mengeset status_kredit awal belum lunas
    :new.status_kredit := 'belum lunas';
        
    -- mengeset semua value pada fotocopy dengan kode_kredit dan jenis fotocopynya
    :new.fotocopy_kk := trim(to_char (:new.kode_kredit))||'_fc_kk.jpg';
    :new.fotocopy_ktp := trim(to_char (:new.kode_kredit))||'_fc_ktp.jpg';
    :new.fotocopy_slip_gaji := trim(to_char (:new.kode_kredit))||'_fc_slg.jpg';
end;


/*
*  membuat trigger uk_cicilan before insert untuk unik kode_cicilan, mengeset tanggal_bayar,
*  mengurangi sisa_kredit pada table kredit, mengecek tanggal jatuh tempo untuk denda, menentukan harga_cicilan
*  dan menentukan cicilan ke berapa 
*/
create or replace trigger uk_cicilan
    before insert on cicilan
    for each row
    declare
    -- deklarasi variabel yang dibutuhkan
    jumlah_angsuran number;
    sisa_kredit number;
    cicilan_ke number;
    jatuh_tempo date;
    tanggal_bayar date;
    tanggal_kredit date;
    selisih_bulan number;
    denda number;
    -- membuat cursor cukre untuk mengambil kode_paket, sisa_kredit, tanggal_kredit dari tabel kredit 
    -- sesuai kode_kredit table cicilan
    cursor cukre is
        select
            kredit.kode_paket, kredit.sisa_kredit, kredit.tanggal_kredit  
        from
            kredit
        where
            kredit.kode_kredit = :new.kode_kredit; -- referensi ke table kredit dari kode_kredit
    
begin
    -- menambahkan karakter 'CCL' diawal kode_cicilan pada setiap kode_cicilan yang baru
    :new.kode_cicilan := 'CCL'||trim(to_char (:new.kode_cicilan));
    
    --set denda adalah nol 0
    denda :=0;
    -- looping untuk mengurai cursor cukre dan kredit_fech mengambil data dari cukre kemudian diuraikan
    for kredit_fetch in cukre
    loop
        -- mencari jumlah_angsuran pada paket_kredit tertentu
        select
            paket_kredit.jumlah_angsuran into jumlah_angsuran
        from
            paket_kredit
        where
            paket_kredit.kode_paket = kredit_fetch.kode_paket;
        -- menset sisa kredit
        sisa_kredit := kredit_fetch.sisa_kredit;
        -- menset tanggal_kredit
        tanggal_kredit := kredit_fetch.tanggal_kredit;
    end loop;
    -- menentukan cicilan_ke
    cicilan_ke := jumlah_angsuran-sisa_kredit+1;
    -- menentukan jatuh tempo dari tanggal_kredit dikalikan sebanyak letak cicilan sekarang
    jatuh_tempo := add_months(tanggal_kredit,cicilan_ke);
    
    -- update table kredit dan mengurangi sisa_kredit dari kode_kredit yang diinput
    update
        kredit
    set
        kredit.sisa_kredit = sisa_kredit-1
    where
        kredit.kode_kredit = :new.kode_kredit;
    
    -- menentukan variabel tanggal_bayar dari tanggal_transaksi table transaksi dari kode_transaksi yang diinput
    select
        transaksi.tgl_transaksi into tanggal_bayar
    from
        transaksi
    where
        transaksi.kode_transaksi = :new.kode_transaksi;
        
    -- jika sisa_kredit kurang dari 1 atau nol
    if sisa_kredit <= 1 then
        -- update table kredit dan memberikan status lunas pada table kredit dari kode_kredit yang diinput
        update
            kredit
        set
            kredit.status_kredit = 'lunas'
        where
            kredit.kode_kredit = :new.kode_kredit;
    
    end if;
    -- menghitung selisih bulan dari tanggal bayar cicilan dengan jatuh tempo
    selisih_bulan := months_between(tanggal_bayar, jatuh_tempo);
    -- jika selisih bulan lebih besar dari nol
    if selisih_bulan > 0 then
        denda := find_angsuran(:new.kode_kredit)*0.05; -- denda diset dari 5% dari harga angsuran
    end if;
    
    :new.denda := denda; -- set denda
    :new.harga_cicilan := find_angsuran(:new.kode_kredit) + denda;  -- set harga_cicilan + denda
    :new.tanggal_bayar := tanggal_bayar; -- set tanggal_bayar
    :new.jatuh_tempo := jatuh_tempo; -- set jatuh_tempo
    :new.cicilan_ke := cicilan_ke; -- set cicilan_ke
end;


/*
*  membuat trigger uk_merek before insert untuk unik kode_merek
*/
create or replace trigger uk_merek
    before insert on merek
    for each row
begin
    -- menambahkan karakter 'MRK' diawal kode_merek pada setiap kode_merek yang baru
    :new.kode_merek := 'MRK'||trim(to_char (:new.kode_merek));
end;


/*
*  membuat trigger uk_tipe before insert untuk unik kode_tipe
*/
create or replace trigger uk_tipe
    before insert on tipe
    for each row
begin
    -- menambahkan karakter 'T' diawal kode_tipe pada setiap kode_tipe yang baru
    :new.kode_tipe := 'T'||trim(to_char (:new.kode_tipe));
end;


/*
*  membuat trigger uk_mobil before insert untuk unik kode_mobil
*/
create or replace trigger uk_mobil
    before insert on mobil
    for each row
    declare
        sub_merek char(3); -- deklarasi variabel penampung sub merek
begin
    -- mengambil sub merek dari nama merek pada table merek sesuai kode_merek mobil
    select 
        -- mengambil nama merek kemudian di ambil 3 kata dari depan kemudian di jadikan huruf besar
        upper(substr(merek.nama_merek,0,3))
        into 
        sub_merek 
    from
        merek 
    where 
        merek.kode_merek = :new.kode_merek;
    
    -- menambahkan karakter menggunakan sub_merek diawal kode_mobil pada setiap kode_mobil yang baru
    :new.kode_mobil := sub_merek||trim(to_char (:new.kode_mobil));
    
    -- mengeset value pada gambar dengan kode_mobil dan _pic.jpg
    :new.gambar := trim(to_char (:new.kode_mobil))||'_pic.jpg';
end;


/*
*  membuat trigger uk_paket before insert untuk unik kode_paket table paket_kredit
*/
create or replace trigger uk_paket
    before insert on paket_kredit
    for each row
begin
    -- menambahkan karakter 'PKT' diawal kode_paket pada setiap kode_paket yang baru
    :new.kode_paket := 'PKT'||trim(to_char (:new.kode_paket));
end;

/* ------ end of trigger operasi before insert ------ */


/* ------ trigger operasi before update ------ */

/*
*  membuat trigger cek_pr_update_customer before update untuk mencegah update NIK primary
*/
create or replace trigger cek_pr_update_customer
    before update on customer
    for each row
begin
    -- jika NIK baru tidak sama dengan NIK yang lama
    if(:new.NIK <> :old.NIK) then
        raise_application_error(-20001,'NIK customer tidak bisa diubah..!');
    end if;
end;


/*
*  membuat trigger cek_pr_update_sales before update untuk mencegah update kode_sales primary
*/
create or replace trigger cek_pr_update_sales
    before update on sales
    for each row
begin
    -- jika kode_sales baru tidak sama dengan kode_sales yang lama
    if(:new.kode_sales <> :old.kode_sales) then
        raise_application_error(-20001,'kode_sales sales tidak bisa diubah..!');
    end if;
end;


/*
*  membuat trigger cek_pr_update_tipe before update untuk mencegah update kode_tipe primary
*/
create or replace trigger cek_pr_update_tipe
    before update on tipe
    for each row
begin
    -- jika kode_tipe baru tidak sama dengan kode_tipe yang lama
    if(:new.kode_tipe <> :old.kode_tipe) then
        raise_application_error(-20001,'kode_tipe tipe tidak bisa diubah..!');
    end if;
end;


/*
*  membuat trigger cek_pr_update_merek before update untuk mencegah update kode_merek primary
*/
create or replace trigger cek_pr_update_merek
    before update on merek
    for each row
begin
    -- jika kode_merek baru tidak sama dengan kode_merek yang lama
    if(:new.kode_merek <> :old.kode_merek) then
        raise_application_error(-20001,'kode_merek merek tidak bisa diubah..!');
    end if;
end;

/*
*  membuat trigger cek_pr_update_mobil before update untuk mencegah update kode_mobil primary
*/
create or replace trigger cek_pr_update_mobil
    before update on mobil
    for each row
begin
    -- jika kode_mobil baru tidak sama dengan kode_mobil yang lama
    if(:new.kode_mobil <> :old.kode_mobil) then
        raise_application_error(-20001,'kode_mobil mobil tidak bisa diubah..!');
    end if;
end;


/*
*  membuat trigger cek_pr_update_paket before update untuk mencegah update kode_paket primary
*/
create or replace trigger cek_pr_update_paket
    before update on paket_kredit
    for each row
begin
    -- jika kode_paket baru tidak sama dengan kode_paket yang lama
    if(:new.kode_paket <> :old.kode_paket) then
        raise_application_error(-20001,'kode_paket paket_kredit tidak bisa diubah..!');
    end if;
end;


/*
*  membuat trigger cek_pr_update_transaksi before update untuk mencegah update kode_transaksi primary
*/
create or replace trigger cek_pr_update_transaksi
    before update on transaksi
    for each row
begin
    -- jika kode_transaksi baru tidak sama dengan kode_transaksi yang lama
    if(:new.kode_transaksi <> :old.kode_transaksi) then
        raise_application_error(-20001,'kode_transaksi transaksi tidak bisa diubah..!');
    end if;
end;


/*
*  membuat trigger cek_pr_update_kredit before update untuk mencegah update kode_kredit primary
*/
create or replace trigger cek_pr_update_kredit
    before update on kredit
    for each row
begin
    -- jika kode_kredit baru tidak sama dengan kode_kredit yang lama
    if(:new.kode_kredit <> :old.kode_kredit) then
        raise_application_error(-20001,'kode_kredit kredit tidak bisa diubah..!');
    end if;
end;


/*
*  membuat trigger cek_pr_update_cash before update untuk mencegah update kode_cash primary
*/
create or replace trigger cek_pr_update_cash
    before update on cash
    for each row
begin
    -- jika kode_cash baru tidak sama dengan kode_cash yang lama
    if(:new.kode_cash <> :old.kode_cash) then
        raise_application_error(-20001,'kode_cash cash tidak bisa diubah..!');
    end if;
end;


/*
*  membuat trigger cek_pr_update_cicilan before update untuk mencegah update kode_cicilan primary
*/
create or replace trigger cek_pr_update_cicilan
    before update on cicilan
    for each row
begin
    -- jika kode_cicilan baru tidak sama dengan kode_cicilan yang lama
    if(:new.kode_cicilan <> :old.kode_cicilan) then
        raise_application_error(-20001,'kode_cicilan cicilan tidak bisa diubah..!');
    end if;
end;

/* ------ end of trigger operasi before update ------ */


/* ------ trigger operasi before delete ------ */
/*
*  membuat trigger cegah_delete_customer before delete untuk mencegah delete customer
*/
create or replace trigger cegah_delete_customer
    before delete on customer
    for each row
begin
    raise_application_error(-20002,'Mohon Maaf Record table customer tidak dapat dihapus');
end;


/*
*  membuat trigger cegah_delete_tipe before delete untuk mencegah delete tipe
*/
create or replace trigger cegah_delete_tipe
    before delete on tipe
    for each row
begin
    raise_application_error(-20002,'Mohon Maaf Record table tipe tidak dapat dihapus');
end;


/*
*  membuat trigger cegah_delete_merek before delete untuk mencegah delete merek
*/
create or replace trigger cegah_delete_merek
    before delete on merek
    for each row
begin
    raise_application_error(-20002,'Mohon Maaf Record table merek tidak dapat dihapus');
end;


/*
*  membuat trigger cegah_delete_paket before delete untuk mencegah delete paket_kredit
*/
create or replace trigger cegah_delete_paket
    before delete on paket_kredit
    for each row
begin
    raise_application_error(-20002,'Mohon Maaf Record table paket_kredit tidak dapat dihapus');
end;


/*
*  membuat trigger cegah_delete_sales before delete untuk mencegah delete sales
*/
create or replace trigger cegah_delete_sales
    before delete on sales
    for each row
begin
    raise_application_error(-20002,'Mohon Maaf Record table sales tidak dapat dihapus');
end;


/*
*  membuat trigger cegah_delete_mobil before delete untuk mencegah delete mobil
*/
create or replace trigger cegah_delete_mobil
    before delete on mobil
    for each row
begin
    raise_application_error(-20002,'Mohon Maaf Record table mobil tidak dapat dihapus');
end;

/*
*  membuat trigger cegah_delete_kredit before delete untuk mencegah delete kredit
*/
create or replace trigger cegah_delete_kredit
    before delete on kredit
    for each row
begin
    raise_application_error(-20002,'Mohon Maaf Record table kredit tidak dapat dihapus');
end;


/*
*  membuat trigger cegah_delete_cash before delete untuk mencegah delete cash
*/
create or replace trigger cegah_delete_cash
    before delete on cash
    for each row
begin
    raise_application_error(-20002,'Mohon Maaf Record table cash tidak dapat dihapus');
end;


/*
*  membuat trigger cegah_delete_cicilan before delete untuk mencegah delete cicilan
*/
create or replace trigger cegah_delete_cicilan
    before delete on cicilan
    for each row
begin
    raise_application_error(-20002,'Mohon Maaf Record table cicilan tidak dapat dihapus');
end;


/*
*  membuat trigger cegah_delete_cicilan before delete untuk mencegah delete cicilan
*/
create or replace trigger cegah_delete_transaksi
    before delete on transaksi
    for each row
begin
    raise_application_error(-20002,'Mohon Maaf Record table transaksi tidak dapat dihapus');
end;

/* ------ end of trigger operasi before delete ------ */



/* 
*  =========== End of Triggers ===========
*/



/* 
*  =========== #5 Database Manipulation Language(DML) start here ===========
*/

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


insert into 
customer
(NIK,
nama_customer,
alamat_customer,
telepon_customer)
values
(
'7247923479266633',
'cahyo moryo',
'jalan koto no 4',
'082214399999'
);


insert into 
customer
(NIK,
nama_customer,
alamat_customer,
telepon_customer)
values
(
'99999922222222',
'hamdani',
'jalan ditao no 4',
'082214399929'
);


insert into 
customer
(NIK,
nama_customer,
alamat_customer,
telepon_customer)
values
(
'1122400999000',
'wilson',
'jalan morson',
'0822143999766'
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
'T10001',
'MRK10001'
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
'T10001',
'MRK10002'
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
'T10002',
'MRK10003'
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
'T10004',
'MRK10004'
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
'Camry 2.5 v',
'Putih',
'521420190',
'masa depan yang lebih cerah',
'T10004',
'MRK10002'
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
'Camry 3.5 v',
'Putih',
'551420190',
'masa depan yang lebih cerah',
'T10003',
'MRK10002'
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
'Camry 1 v',
'merah',
'501420190',
'masa depan yang lebih cerah dan bersahabat',
'T10001',
'MRK10002'
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
'series 2 F45',
'hitam',
'435900000',
'Mobil keluarga mewah',
'T10002',
'MRK10004'
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
'X1',
'hitam',
'455900000',
'Mobil segala rintangan',
'T10004',
'MRK10003'
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
'M3',
'merah',
'732200000',
'mobil luxury',
'T10001',
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
'Q5',
'putih',
'623500000',
'mobil mewah berteknologi',
'T10004',
'MRK10004'
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
'S5',
'merah',
'853500000',
'mobil kompak eksekutif',
'T10003',
'MRK10003'
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
'Dutro 110 HD',
'hijau',
'453500000',
'truck lincah dan bertenaga',
'T10002',
'MRK10002'
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
'FRR190PS',
'putih',
'745400000',
'volume besar hemat solar',
'T10002',
'MRK10001'
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
'Sirion',
'biru',
'455900000',
'City car lincah bertenaga',
'T10002',
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
'Trajet',
'putih',
'558500000',
'mobil di segala cuaca',
'T10004',
'MRK10002'
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
'Equinox',
'hitam',
'758500000',
'mobil bertenaga besar',
'T10002',
'MRK10003'
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
'S1100'
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
'S1101'
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
'S1100'
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
'9493481115834848',
to_date('22/07/2016','dd/mm/yyyy'),
'tunai',
'S1102'
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
'S1103'
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
'S1104'
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
'S1103'
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
'S1102'
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
'S1102'
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
'S1101'
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
'S1100'
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
'S1103'
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
'S1103'
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
'S1102'
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
'S1100'
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
'S1100'
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
'S1102'
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
'S1101'
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
'S1103'
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
'S1104'
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
'S1103'
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
'S1102'
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
'S1101'
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
'S1100'
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
'S1101'
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
'S1102'
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
'S1103'
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
'S1104'
);
-- disini 2

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
'1122400999000       ',
to_date('28/01/2016','dd/mm/yyyy'),
'tunai',
'S1103'
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
'7247923479266633    ',
to_date('10/01/2016','dd/mm/yyyy'),
'tunai',
'S1102'
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
'99999922222222      ',
to_date('12/04/2016','dd/mm/yyyy'),
'tunai',
'S1104'
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
to_date('10/03/2016','dd/mm/yyyy'),
'tunai',
'S1100'
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
'9493481115834848    ',
to_date('11/01/2015','dd/mm/yyyy'),
'tunai',
'S1102'
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
to_date('09/09/2016','dd/mm/yyyy'),
'tunai',
'S1101'
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
'99999922222222      ',
to_date('10/07/2016','dd/mm/yyyy'),
'tunai',
'S1103'
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
'9493481115834848    ',
to_date('25/12/2016','dd/mm/yyyy'),
'tunai',
'S1104'
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
to_date('28/10/2016','dd/mm/yyyy'),
'tunai',
'S1103'
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
to_date('11/08/2016','dd/mm/yyyy'),
'tunai',
'S1100'
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
to_date('12/01/2016','dd/mm/yyyy'),
'tunai',
'S1103'
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
'7247923479266633    ',
to_date('10/01/2016','dd/mm/yyyy'),
'tunai',
'S1100'
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
to_date('09/05/2016','dd/mm/yyyy'),
'tunai',
'S1101'
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
to_date('11/01/2016','dd/mm/yyyy'),
'tunai',
'S1102'
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
'S1101'
);




insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('10/11/2016','dd/mm/yyyy'),
'tunai',
'S1104'
);



insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('10/12/2016','dd/mm/yyyy'),
'tunai',
'S1103'
);

insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('08/01/2017','dd/mm/yyyy'),
'tunai',
'S1102'
);


insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('09/02/2017','dd/mm/yyyy'),
'tunai',
'S1104'
);


insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('10/03/2017','dd/mm/yyyy'),
'tunai',
'S1101'
);


insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('05/04/2017','dd/mm/yyyy'),
'tunai',
'S1104'
);


insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('08/05/2017','dd/mm/yyyy'),
'tunai',
'S1103'
);


insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('09/06/2017','dd/mm/yyyy'),
'tunai',
'S1101'
);


insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('10/07/2017','dd/mm/yyyy'),
'tunai',
'S1104'
);


insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('08/08/2017','dd/mm/yyyy'),
'tunai',
'S1104'
);
-- disini


insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('08/04/2016','dd/mm/yyyy'),
'tunai',
'S1104'
);


insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('08/03/2016','dd/mm/yyyy'),
'tunai',
'S1104'
);


insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('08/02/2016','dd/mm/yyyy'),
'tunai',
'S1104'
);


insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('08/01/2016','dd/mm/yyyy'),
'tunai',
'S1104'
);


insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('08/12/2015','dd/mm/yyyy'),
'tunai',
'S1104'
);


insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('08/11/2015','dd/mm/yyyy'),
'tunai',
'S1104'
);


insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('08/10/2015','dd/mm/yyyy'),
'tunai',
'S1104'
);


insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('08/09/2015','dd/mm/yyyy'),
'tunai',
'S1104'
);

insert into transaksi --
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_sales
)
values(
s_transaksi.nextVal,
'99999922222222      ',
to_date('08/08/2015','dd/mm/yyyy'),
'tunai',
'S1104'
);

-- end disini 2
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
/*
exec in_bonus_sales('TRX100001','MIT10000');
exec in_peluang_cust('TRX100001','MIT10000');
*/
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
'MIT10001',
'PKT10001'
);


insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100002',
'TOY10003',
'PKT10002'
);


insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100004',
'HON10002',
'PKT10001'
);


insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100004',
'MIT10001',
'PKT10000'
);

insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100043',
'MIT10000',
'PKT10003'
);
insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100025',
'MIT10000',
'PKT10003'
);
/*
exec in_bonus_sales('TRX100001','MIT10000');
exec in_peluang_cust('TRX100001','MIT10000');
*/
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
'MIT10001',
'PKT10001'
);


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
'TOY10003',
'PKT10002'
);


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
'HON10002',
'PKT10001'
);


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
'MIT10001',
'PKT10000'
);

insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100020',
'MIT10000',
'PKT10003'
);

insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100025',
'MIT10000',
'PKT10003'
);
/*
exec in_bonus_sales('TRX100001','MIT10000');
exec in_peluang_cust('TRX100001','MIT10000');
*/
insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100060',
'MIT10001',
'PKT10001'
);


insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100059',
'TOY10003',
'PKT10002'
);


insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100058',
'HON10002',
'PKT10001'
);


insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100057',
'MIT10001',
'PKT10000'
);

insert into kredit
(
kode_kredit,
kode_transaksi,
kode_mobil,
kode_paket
)
values(
s_kredit.nextVal,
'TRX100056',
'MIT10000',
'PKT10003'
);


-- # insert data sampai sini #

/* insert cicilan */
insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100009',
'BKR10001'
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
'BKR10002'
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
'BKR10004'
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
'TRX100027',
'BKR10003'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100008',
'BKR10002'
);


insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100009',
'BKR10001'
);


insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100044',
'BKR10005'
);
-- disini 3


insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100051',
'BKR10005'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100054',
'BKR10005'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100053',
'BKR10005'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100048',
'BKR10005'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100047',
'BKR10005'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100055',
'BKR10005'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100045',
'BKR10005'
);
-- disini

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100065',
'BKR10003'
);
insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100064',
'BKR10003'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100063',
'BKR10003'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100062',
'BKR10003'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100061',
'BKR10003'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100066',
'BKR10003'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100055',
'BKR10003'
);

insert into cicilan
(
kode_cicilan,
kode_transaksi,
kode_kredit
)
values(
s_cicilan.nextVal,
'TRX100045',
'BKR10003'
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
'TRX100006',
'MIT10001'
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
'TRX100003',
'HON10002'
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
'TRX100018',
'HON10002'
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
'TRX100019',
'SUZ10006'
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
'TRX100010',
'MIT10001'
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
'TRX100009',
'HON10002'
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
'TRX100011',
'TOY10003'
);
-- disini
insert into cash
(
kode_cash,
kode_transaksi,
kode_mobil
)
values
(
s_cash.nextVal,
'TRX100035',
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
'TRX100034',
'MIT10001'
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
'TRX100033',
'HON10002'
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
'TRX100032',
'HON10002'
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
'TRX100031',
'SUZ10006'
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
'TRX100030',
'MIT10001'
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
'TRX100029',
'HON10002'
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
'TRX100028',
'TOY10003'
);
-- disini
insert into cash
(
kode_cash,
kode_transaksi,
kode_mobil
)
values
(
s_cash.nextVal,
'TRX100043',
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
'TRX100042',
'MIT10001'
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
'TRX100041',
'HON10002'
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
'HON10002'
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
'TRX100039',
'SUZ10006'
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
'TRX100038',
'MIT10001'
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
'TRX100037',
'HON10002'
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
'TRX100036',
'TOY10003'
);

-- disini
insert into cash
(
kode_cash,
kode_transaksi,
kode_mobil
)
values
(
s_cash.nextVal,
'TRX100043',
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
'TRX100017',
'MIT10001'
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
'TRX100016',
'HON10002'
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
'TRX100015',
'HON10002'
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
'TRX100014',
'SUZ10006'
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
'TRX100013',
'MIT10001'
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
'TRX100012',
'HON10002'
);

-- menjalankan prosedur untuk menghitung transaksi
exec hitung_transaksi('TRX100000');
exec hitung_transaksi('TRX100001');
exec hitung_transaksi('TRX100002');
exec hitung_transaksi('TRX100003');
exec hitung_transaksi('TRX100004');
exec hitung_transaksi('TRX100005');
exec hitung_transaksi('TRX100006');
exec hitung_transaksi('TRX100007');
exec hitung_transaksi('TRX100008');
exec hitung_transaksi('TRX100009');
exec hitung_transaksi('TRX100010');
exec hitung_transaksi('TRX100011');
exec hitung_transaksi('TRX100012');
exec hitung_transaksi('TRX100013');
exec hitung_transaksi('TRX100014');
exec hitung_transaksi('TRX100015');
exec hitung_transaksi('TRX100016');
exec hitung_transaksi('TRX100017');
exec hitung_transaksi('TRX100018');
exec hitung_transaksi('TRX100019');
exec hitung_transaksi('TRX100020');
exec hitung_transaksi('TRX100021');
exec hitung_transaksi('TRX100022');
exec hitung_transaksi('TRX100023');
exec hitung_transaksi('TRX100024');
exec hitung_transaksi('TRX100025');
exec hitung_transaksi('TRX100026');
exec hitung_transaksi('TRX100027');
--
exec hitung_transaksi('TRX100028');
exec hitung_transaksi('TRX100029');
exec hitung_transaksi('TRX100030');
exec hitung_transaksi('TRX100031');
exec hitung_transaksi('TRX100032');
exec hitung_transaksi('TRX100033');
exec hitung_transaksi('TRX100034');
exec hitung_transaksi('TRX100035');
exec hitung_transaksi('TRX100036');
exec hitung_transaksi('TRX100037');
exec hitung_transaksi('TRX100038');
exec hitung_transaksi('TRX100039');
exec hitung_transaksi('TRX100040');
exec hitung_transaksi('TRX100041');
exec hitung_transaksi('TRX100042');
exec hitung_transaksi('TRX100043');
exec hitung_transaksi('TRX100044');
exec hitung_transaksi('TRX100045');
exec hitung_transaksi('TRX100046');
exec hitung_transaksi('TRX100047');
exec hitung_transaksi('TRX100048');
exec hitung_transaksi('TRX100049');
exec hitung_transaksi('TRX100050');
exec hitung_transaksi('TRX100051');
exec hitung_transaksi('TRX100052');
exec hitung_transaksi('TRX100053');
exec hitung_transaksi('TRX100054');
exec hitung_transaksi('TRX100055');
exec hitung_transaksi('TRX100056');
exec hitung_transaksi('TRX100057');
exec hitung_transaksi('TRX100058');
exec hitung_transaksi('TRX100059');
exec hitung_transaksi('TRX100060');
exec hitung_transaksi('TRX100061');
exec hitung_transaksi('TRX100062');
exec hitung_transaksi('TRX100063');
exec hitung_transaksi('TRX100064');
exec hitung_transaksi('TRX100065');
exec hitung_transaksi('TRX100066');

select * from transaksi;

/* 
*  =========== End of Database Manipulation Language(DML) ===========
*/



/* 
*  =========== #6 View start here ===========
*/

-- view masing -masing table
create or replace view v_cicilan as select * from cicilan;

create or replace view v_kredit as select * from kredit;

create or replace view v_cash as select * from cash;

create or replace view v_transaksi as select * from transaksi;

create or replace view v_paket_kredit as select * from paket_kredit;

create or replace view v_mobil as select * from mobil;

create or replace view v_merek as select * from merek;

create or replace view v_tipe as select * from tipe;

create or replace view v_sales as select * from sales;

create or replace view v_customer as select * from customer;


-- operasi tanggal transaksi

-- view menampilkan transaksi perbulannya dan jumlah transaksi beserta total harga pembelian dalam sebulan
create or replace view v_trans_perbulan as
select
    to_char(tgl_transaksi, 'YYYY-MONTH') as TAHUN_BULAN, -- untuk tampil tahun dan bulan
    count(kode_transaksi) as jumlah_transaksi, -- menghitung banyak transaksi
    sum(total_harga) as harga_total --menjumlahkan total harga
from
    transaksi
group by
    to_char(tgl_transaksi, 'YYYY-MONTH') -- gruping pertahun bulan
;

-- view menampilkan transaksi perhari dan jumlah transaksi beserta total harga pembelian dalam sehari
create or replace view v_trans_perhari as
select
    to_char(tgl_transaksi, 'DD-MONTH-YYYY') as hari, -- untuk tampil hari ex: 3 JAN 2017
    count(kode_transaksi) as jumlah_transaksi, -- menghitung banyak transaksi
    sum(total_harga) as harga_total --menjumlahkan total harga
from
    transaksi
group by
    to_char(tgl_transaksi, 'DD-MONTH-YYYY') -- gruping perhari
;

-- view menampilkan transaksi perhari dalam seminggunya dan jumlah transaksi beserta total harga pembelian perhari dalam seminggu
create or replace view v_trans_perhari_minggu as
select
    to_char(tgl_transaksi, 'DAY') as hari_perminggu, -- untuk tampil nama hari ex: SUNDAY
    count(kode_transaksi) as jumlah_transaksi, -- menghitung banyak transaksi
    sum(total_harga) as harga_total --menjumlahkan total harga
from
    transaksi
group by
    to_char(tgl_transaksi, 'DAY') -- gruping hari perminggu
;

-- end of operasi tanggal transaksi


-- operasi view customer

-- view menampilkan banyak transaksi yang dilakukan setiap customer
create or replace view v_customer_trans_count as
select
    customer.nama_customer as nama_customer, banyak_transaksi
from
    (select
        transaksi.NIK as NIK, count(transaksi.kode_transaksi) as banyak_transaksi
    from
        transaksi
    group by
        transaksi.NIK
    ) customer_transaksi,
    customer
where
    customer_transaksi.NIK = customer.NIK;
    
    
-- view menampilkan banyak transaksi kredit yang dilakukan setiap customer
create or replace view v_customer_trans_kredit_count as
select
    customer.nama_customer as nama_customer, banyak_transaksi_kredit
from
    (
    select
        trx_kredit.NIK as NIK, count(trx_kredit.trx_kode_transaksi) as banyak_transaksi_kredit
    from
        (
        select
            transaksi.NIK as NIK, transaksi.kode_transaksi as trx_kode_transaksi
        from
            kredit, transaksi
        where
            kredit.kode_transaksi = transaksi.kode_transaksi
        ) 
        trx_kredit
    group by
        trx_kredit.NIK
    ) 
    customer_transaksi,  -- sub query untuk mencari banyak transaksi yang dilakukan customer
    customer
where
    customer_transaksi.NIK = customer.NIK;


-- view menampilkan transaksi kredit yang belum lunas yang dilakukan setiap customer
create or replace view v_customer_kredit_belum_lunas as
select
    customer.nama_customer, transaksi.kode_transaksi, kredit.kode_kredit, kredit.TANGGAL_KREDIT as tanggal_kredit, kredit.SISA_KREDIT
from
    customer,
    transaksi,
    kredit
where
    customer.NIK = transaksi.NIK
and
    transaksi.kode_transaksi = kredit.kode_transaksi
and 
    kredit.status_kredit = 'belum lunas';


-- view menampilkan transaksi kredit yang sudah lunas yang dilakukan setiap customer
create or replace view v_customer_kredit_lunas as
select
    customer.nama_customer, transaksi.kode_transaksi, kredit.kode_kredit, kredit.TANGGAL_KREDIT as tanggal_kredit, kredit.SISA_KREDIT
from
    customer,
    transaksi,
    kredit
where
    customer.NIK = transaksi.NIK
and
    transaksi.kode_transaksi = kredit.kode_transaksi
and 
    kredit.status_kredit = 'lunas';


-- view menampilkan mobil yang dibeli kredit yang oleh customer
create or replace view v_customer_mobil_kredit as
select
    customer.nama_customer,kredit.kode_kredit, kredit.tanggal_kredit, mobil.nama_mobil, merek.nama_merek, tipe.nama_tipe
from
    customer,
    transaksi,
    kredit,
    mobil,
    merek,
    tipe
where
    customer.NIK = transaksi.NIK
and
    transaksi.kode_transaksi = kredit.kode_transaksi
and 
    kredit.kode_mobil = mobil.kode_mobil
and 
    mobil.kode_merek = merek.kode_merek
and 
    mobil.kode_tipe = tipe.kode_tipe;
    
    

-- view menampilkan banyak transaksi cash yang dilakukan setiap customer
create or replace view v_customer_trans_cash_count as
select
    customer.nama_customer as nama_customer, banyak_transaksi_cash
from
    (
    select
        trx_cash.NIK as NIK, count(trx_cash.trx_kode_transaksi) as banyak_transaksi_cash
    from
        (
        select
            transaksi.NIK as NIK, transaksi.kode_transaksi as trx_kode_transaksi
        from
            cash, transaksi
        where
            cash.kode_transaksi = transaksi.kode_transaksi
        ) 
        trx_cash
    group by
        trx_cash.NIK
    ) 
    customer_transaksi,
    customer
where
    customer_transaksi.NIK = customer.NIK;



-- view menampilkan transaksi cash yang dilakukan setiap customer
create or replace view v_customer_cash as
select
    customer.nama_customer, transaksi.kode_transaksi, cash.kode_cash, cash.TANGGAL_cash as tanggal_cash
from
    customer,
    transaksi,
    cash
where
    customer.NIK = transaksi.NIK
and
    transaksi.kode_transaksi = cash.kode_transaksi;
    

-- view menampilkan mobil yang dibeli cash yang oleh customer
create or replace view v_customer_mobil_cash as
select
    customer.nama_customer,cash.kode_cash, cash.tanggal_cash, mobil.nama_mobil, merek.nama_merek, tipe.nama_tipe
from
    customer,
    transaksi,
    cash,
    mobil,
    merek,
    tipe
where
    customer.NIK = transaksi.NIK
and
    transaksi.kode_transaksi = cash.kode_transaksi
and 
    cash.kode_mobil = mobil.kode_mobil
and 
    mobil.kode_merek = merek.kode_merek
and 
    mobil.kode_tipe = tipe.kode_tipe;
    

-- view menampilkan banyak transaksi bayar cicilan yang dilakukan setiap customer
create or replace view v_customer_trans_cicilan_count as
select
    customer.nama_customer as nama_customer, banyak_transaksi_cicilan
from
    (
    select
        trx_cicilan.NIK as NIK, count(trx_cicilan.trx_kode_transaksi) as banyak_transaksi_cicilan
    from
        (
        select
            transaksi.NIK as NIK, transaksi.kode_transaksi as trx_kode_transaksi
        from
            cicilan, transaksi
        where
            cicilan.kode_transaksi = transaksi.kode_transaksi
        ) 
        trx_cicilan
    group by
        trx_cicilan.NIK
    ) 
    customer_transaksi,
    customer
where
    customer_transaksi.NIK = customer.NIK;


-- end operasi view customer


--  operasi view sales

-- view menampilkan banyak transaksi yang dilakukan setiap sales
create or replace view v_sales_trans_count as
select
    sales.nama_sales as nama_sales, banyak_transaksi -- tampil nama sales dan banyak transaksi
from
    (select
        transaksi.kode_sales as kode_sales, count(transaksi.kode_transaksi) as banyak_transaksi -- mengluarkan kode_sales dan banyak transaki
    from
        transaksi
    group by
        transaksi.kode_sales
    ) sales_work, -- sub query untuk mencari banyak transaksi yang dilakukan sales
    sales -- untuk digabung dengan table sales
where
    sales_work.kode_sales = sales.kode_sales;

-- view menampilkan banyak transaksi kredit yang dilakukan setiap sales
create or replace view v_sales_trans_kredit_count as
select
    sales.nama_sales as nama_sales, banyak_transaksi_kredit
from
    (
    select
        trx_kredit.kode_sales as kode_sales, count(trx_kredit.trx_kode_transaksi) as banyak_transaksi_kredit
    from
        (
        select
            transaksi.kode_sales as kode_sales, transaksi.kode_transaksi as trx_kode_transaksi
        from
            kredit, transaksi
        where
            kredit.kode_transaksi = transaksi.kode_transaksi
        ) 
        trx_kredit
    group by
        trx_kredit.kode_sales
    ) 
    sales_transaksi,  -- sub query untuk mencari banyak transaksi yang dilakukan sales
    sales
where
    sales_transaksi.kode_sales = sales.kode_sales;


-- view menampilkan transaksi kredit yang dilakukan sales
create or replace view v_sales_kredit as
select
    sales.nama_sales, transaksi.kode_transaksi, kredit.kode_kredit, kredit.TANGGAL_KREDIT as tanggal_kredit
from
    sales,
    transaksi,
    kredit
where
    sales.kode_sales = transaksi.kode_sales
and
    transaksi.kode_transaksi = kredit.kode_transaksi;
    

-- view menampilkan banyak transaksi cash yang dilakukan sales
create or replace view v_sales_trans_cash_count as
select
    sales.nama_sales as nama_sales, banyak_transaksi_cash
from
    (
    select
        trx_cash.kode_sales as kode_sales, count(trx_cash.trx_kode_transaksi) as banyak_transaksi_cash
    from
        (
        select
            transaksi.kode_sales as kode_sales, transaksi.kode_transaksi as trx_kode_transaksi
        from
            cash, transaksi
        where
            cash.kode_transaksi = transaksi.kode_transaksi
        ) 
        trx_cash
    group by
        trx_cash.kode_sales
    ) 
    sales_transaksi,
    sales
where
    sales_transaksi.kode_sales = sales.kode_sales;



-- view menampilkan transaksi cash yang dilakukan setiap sales
create or replace view v_sales_cash as
select
    sales.nama_sales, transaksi.kode_transaksi, cash.kode_cash, cash.TANGGAL_cash as tanggal_cash
from
    sales,
    transaksi,
    cash
where
    sales.kode_sales = transaksi.kode_sales
and
    transaksi.kode_transaksi = cash.kode_transaksi;


-- view menampilkan banyak transaksi bayar cicilan yang dilakukan setiap sales
create or replace view v_sales_trans_cicilan_count as
select
    sales.nama_sales as nama_sales, banyak_transaksi_cicilan
from
    (
    select
        trx_cicilan.kode_sales as kode_sales, count(trx_cicilan.trx_kode_transaksi) as banyak_transaksi_cicilan
    from
        (
        select
            transaksi.kode_sales as kode_sales, transaksi.kode_transaksi as trx_kode_transaksi
        from
            cicilan, transaksi
        where
            cicilan.kode_transaksi = transaksi.kode_transaksi
        ) 
        trx_cicilan
    group by
        trx_cicilan.kode_sales
    ) 
    sales_transaksi,
    sales
where
    sales_transaksi.kode_sales = sales.kode_sales;


-- end sales


-- operasi mobil

-- view menampilkan banyak mobil yang terjual secara cash
create or replace view v_mobil_cash_count as
select
    mobil.nama_mobil as nama_mobil, banyak_terjual_cash
from
    (
    select
        c_mobil.kode_mobil as kode_mobil, count(c_mobil.kode_mobil) as banyak_terjual_cash
    from
        (
        select
            mobil.kode_mobil as kode_mobil
        from
            cash,
            mobil
        where
            cash.kode_mobil = mobil.kode_mobil
        ) c_mobil
    group by
        c_mobil.kode_mobil
    ) gr_mobil,
    mobil
where
    gr_mobil.kode_mobil = mobil.kode_mobil;
    
    
-- view menampilkan banyak mobil yang terjual secara kredit
create or replace view v_mobil_kredit_count as
select
    mobil.nama_mobil as nama_mobil, banyak_terjual_kredit
from
    (
    select
        c_mobil.kode_mobil as kode_mobil, count(c_mobil.kode_mobil) as banyak_terjual_kredit
    from
        (
        select
            mobil.kode_mobil as kode_mobil
        from
            kredit,
            mobil
        where
            kredit.kode_mobil = mobil.kode_mobil
        ) c_mobil
    group by
        c_mobil.kode_mobil
    ) gr_mobil,
    mobil
where
    gr_mobil.kode_mobil = mobil.kode_mobil;

-- end of operasi view mobil
    
-- menjalankan view

select * from v_trans_perhari;

select * from v_trans_perhari_minggu;

select * from v_trans_perbulan;

select * from v_customer_trans_count;

select * from v_customer_trans_kredit_count;

select * from v_customer_kredit_lunas;

select * from v_customer_kredit_belum_lunas;

select * from v_customer_mobil_kredit;

select * from v_customer_trans_cash_count;

select * from v_customer_cash;

select * from v_customer_mobil_cash;

select * from v_customer_trans_cicilan_count;

select * from v_sales_trans_count;

select * from v_sales_trans_kredit_count;

select * from v_sales_kredit;

select * from v_sales_trans_cash_count;

select * from v_sales_cash;

select * from v_sales_trans_cicilan_count;

select * from v_mobil_cash_count;

select * from v_mobil_kredit_count;

select * from v_cicilan;

select * from v_kredit;

select * from v_cash;

select * from v_transaksi;

select * from v_paket_kredit;

select * from v_mobil;

select * from v_merek;

select * from v_tipe;

select * from v_sales;

select * from v_customer;

/* 
*  =========== End of View ===========
*/
