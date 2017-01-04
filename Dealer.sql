/* 
This is project of Dealer Database System.
Created by Ricko Virnanda & Muhammad Fariz Syakur A
On Esa Unggul University
Date Created 04 Jan 2017
Make for Oracle Database environment
Using SQL(Structured Query Languange) for Structured code sintax 
*/


/*
* Data Definition Language (DDL) start here 
*/

-- create table for petugas
create table tbl_petugas (
    kode_petugas varchar2(10) not null,
    nama_petugas varchar2(50) not null,
    password char(100) not null,
    foto char(100) not null,
    primary key(kode_petugas)
);

create table tbl_customer(
    NIK char(20) not null,
    nama_customer varchar2(30) not null,
    alamat_customer char(150) not null,
    telepon_customer char(25) not null,
    primary key(NIK)
);

create table tbl_tipe(
    kode_tipe varchar2(10) not null,
    nama_tipe varchar2(20) not null,
    primary key(kode_tipe)
);


create table tbl_merek(
    kode_merek varchar2(10) not null,
    nama_merek varchar2(20) not null,
    asal_negara varchar2(20) not null,
    primary key(kode_merek)
);

create table tbl_mobil(
    kode_mobil char(10) not null,
    nama_mobil varchar2(20) not null,
    warna varchar2(10) not null,
    harga_mobil number(25) not null,
    deskripsi char(300) not null,
    gambar char(100) not null,
    kode_tipe varchar2(10) not null,
    kode_merek varchar2(10) not null,
    primary key(kode_mobil),
    foreign key(kode_tipe) references tbl_tipe(kode_tipe),
    foreign key(kode_merek) references tbl_merek(kode_merek)
);

create table tbl_transaksi(
    kode_transaksi char(20) not null,
    NIK char(20) not null,
    tgl_transaksi date not null,
    jenis_transaksi char(10) not null,
    foreign key(NIK) references tbl_customer(NIK),
    primary key(kode_transaksi)
);

create table tbl_paket_kredit(
    kode_paket char(10) not null,
    nama_paket varchar2(50) not null,
    dp number(25) not null,
    biaya_angsuran number(20) not null,
    jumlah_angsuran number(5) not null,
    primary key(kode_paket)
);

create table tbl_cash(
    kode_cash char(20) not null,
    harga_cash number(25) not null,
    kode_transaksi char(20) not null,
    primary key(kode_cash),
    foreign key(kode_transaksi) references tbl_transaksi(kode_transaksi)
);

create table tbl_kredit(
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
    foreign key(kode_mobil) references tbl_mobil(kode_mobil),
    foreign key(kode_paket) references tbl_paket_kredit(kode_paket),
    foreign key(kode_transaksi) references tbl_transaksi(kode_transaksi)
);

create table tbl_cicilan(
    kode_cicilan char(20) not null,
    kode_transaksi char(20) not null,
    cicilan_ke number(5) not null,
    harga_cicilan number(20) not null,
    kode_kredit char(20) not null,
    primary key(kode_cicilan),
    foreign key(kode_transaksi) references tbl_transaksi(kode_transaksi),
    foreign key(kode_kredit) references tbl_kredit(kode_kredit)
);
alter table tbl_cicilan add denda number(10) not null;
alter table tbl_cicilan add jatuh_tempo date not null;
alter table tbl_cicilan add tanggal_bayar date not null;

create table tbl_undian(
    NIK char(20) not null,
    kode_mobil char(10) not null,
    foreign key(NIK) references tbl_customer(NIK),
    foreign key(kode_mobil) references tbl_mobil(kode_mobil),
    primary key(NIK, kode_mobil)
);

create table tbl_cust_harian_peluang(
    NIK char(20) not null,
    hari char(20) not null,
    foreign key(NIK) references tbl_customer(NIK),
    primary key(NIK,hari)
);


create table tbl_petugas_merek_bonus(
    kode_petugas char(5) not null,
    kode_merek varchar2(10) not null,
    foreign key(kode_petugas) references tbl_petugas(kode_petugas),
    foreign key(kode_merek) references tbl_merek(kode_merek),
    primary key(kode_petugas, kode_merek)
);

create table tbl_petugas_mobil_bonus(
    kode_petugas char(5) not null,
    kode_mobil char(10) not null,
    foreign key(kode_petugas) references tbl_petugas(kode_petugas),
    foreign key(kode_mobil) references tbl_mobil(kode_mobil),
    primary key(kode_petugas, kode_mobil)
);

create table tbl_merek_mobil_bonus(
    kode_merek varchar2(10) not null,
    kode_mobil char(10) not null,
    foreign key(kode_mobil) references tbl_mobil(kode_mobil),
    foreign key(kode_merek) references tbl_merek(kode_merek),
    primary key(kode_mobil, kode_merek)
);


alter table tbl_undian rename to tbl_cust_mobil_peluang;

alter table tbl_cust_harian_peluang rename to tbl_cust_hari_peluang;

alter table tbl_petugas modify kode_petugas char(5);

alter table tbl_kredit add tanggal_kredit date not null;
alter table tbl_cash add tanggal_cash date not null;

alter table tbl_transaksi add kode_petugas char(5) not null;

alter table tbl_transaksi add foreign key(kode_petugas) references tbl_petugas(kode_petugas);

alter table tbl_cash add kode_mobil char(10) not null;

alter table tbl_cash add foreign key(kode_mobil) references tbl_mobil(kode_mobil);

alter table tbl_transaksi add total_harga number(25) not null;

alter table tbl_cash drop column harga_cash;

alter table tbl_paket_kredit modify dp number(7,3);

alter table tbl_paket_kredit modify biaya_angsuran number(7,3);

alter table tbl_petugas_merek_bonus modify kode_petugas char(5);

alter table tbl_petugas_mobil_bonus modify kode_petugas char(5);

/* end of DDL */


/* Creating sequences */

/*
mengecek sequence
SELECT s_petugas.nextVal FROM DUAL;
*/

create sequence s_petugas start with 1100;

create sequence s_transaksi start with 100000;

create sequence s_cash start with 10000;

create sequence s_kredit start with 10000;

create sequence s_cicilan start with 10000;

create sequence s_mobil start with 10000;

create sequence s_tipe start with 10000;

create sequence s_merek start with 10000;

create sequence s_paket start with 10000;

/* end of sequence */

/* Creating procedure */


create or replace procedure count_total_transaksi(c_kode_transaksi char, c_harga number)
is
    total_harga number;
    total number;
begin
    select 
        tbl_transaksi.total_harga into total_harga
    from
        tbl_transaksi
    where
        tbl_transaksi.kode_transaksi = c_kode_transaksi;
        
    total := total_harga + c_harga;
    
    update
        tbl_transaksi
    set
        tbl_transaksi.total_harga = total
    where
        tbl_transaksi.kode_transaksi = c_kode_transaksi;
end;    


create or replace procedure in_peluang_cust(c_kode_transaksi char, c_kode_mobil char)
is
    NIK char(20);
    hari char(20);
    tgl_transaksi date;
begin
    select
        tbl_transaksi.NIK, tbl_transaksi.tgl_transaksi into NIK, tgl_transaksi
    from
        tbl_transaksi
    where
        tbl_transaksi.kode_transaksi = c_kode_transaksi;
    
    select 
        to_char(to_date(tgl_transaksi,'dd/mm/yyyy'), 'Day') into hari
    from
        dual;
        
    insert into
    tbl_cust_hari_peluang
    values
    (
        NIK,
        hari
    );
       
    insert into
    tbl_cust_mobil_peluang
    values
    (
        NIK,
        c_kode_mobil
    );
    
end;


create or replace procedure up_peluang_cust(c_kode_transaksi char, c_kode_mobil char)
is
    NIK char(20);
begin
    select
        tbl_transaksi.NIK into NIK
    from
        tbl_transaksi
    where
        tbl_transaksi.kode_transaksi = c_kode_transaksi;
    
    update
        tbl_cust_mobil_peluang
    set 
        tbl_cust_mobil_peluang.kode_mobil = c_kode_mobil
    where
        tbl_cust_mobil_peluang.NIK = NIK;    
end;


create or replace procedure dl_peluang_cust(c_kode_transaksi char, c_kode_mobil char)
is
    NIK char(20);
    hari char(20);
    tgl_transaksi date;
begin
    select
        tbl_transaksi.NIK, tbl_transaksi.tgl_transaksi into NIK, tgl_transaksi
    from
        tbl_transaksi
    where
        tbl_transaksi.kode_transaksi = c_kode_transaksi;
    
    select 
        to_char(to_date(tgl_transaksi,'dd/mm/yyyy'), 'Day') into hari
    from
        dual;
        
    delete
    from
        tbl_cust_hari_peluang
    where
        tbl_cust_hari_peluang.NIK = NIK
    and
        tbl_cust_hari_peluang.hari = hari;    
        
    delete
    from
        tbl_cust_mobil_peluang
    where
        tbl_cust_mobil_peluang.NIK = NIK
    and
        tbl_cust_mobil_peluang.kode_mobil = c_kode_mobil;   
end;



create or replace procedure in_bonus_petugas(c_kode_transaksi char, c_kode_mobil char)
is
    kode_petugas char(5);
    kode_merek varchar2(10);
begin
    select
        tbl_transaksi.kode_petugas into kode_petugas
    from
        tbl_transaksi
    where
        tbl_transaksi.kode_transaksi = c_kode_transaksi;
    
    select
        tbl_mobil.kode_merek into kode_merek
    from
        tbl_mobil
    where
        tbl_mobil.kode_mobil = c_kode_mobil;
        
    insert into
    tbl_petugas_merek_bonus
    values
    (
        kode_petugas,
        kode_merek
    );
    
    insert into
    tbl_petugas_mobil_bonus
    values
    (
        kode_petugas,
        c_kode_mobil
    );
    
    insert into
    tbl_merek_mobil_bonus
    values
    (
        kode_merek,
        c_kode_mobil
    );
end;


create or replace procedure up_bonus_petugas(c_kode_transaksi char, c_kode_mobil char, old_kode_mobil char)
is
    kode_petugas char(5);
    kode_merek char(10);
    old_kode_merek char(10);
begin
    select
        tbl_transaksi.kode_petugas into kode_petugas
    from
        tbl_transaksi
    where
        tbl_transaksi.kode_transaksi = c_kode_transaksi;
    
    select
        tbl_mobil.kode_merek into kode_merek
    from
        tbl_mobil
    where
        tbl_mobil.kode_mobil = c_kode_mobil;
    
    select
        tbl_mobil.kode_merek into old_kode_merek
    from
        tbl_mobil
    where
        tbl_mobil.kode_mobil = old_kode_mobil;
    
    update
        tbl_petugas_merek_bonus
    set 
        tbl_petugas_merek_bonus.kode_merek = kode_merek
    where
        tbl_petugas_merek_bonus.kode_petugas = kode_petugas;    
        
    update
        tbl_petugas_mobil_bonus
    set 
        tbl_petugas_mobil_bonus.kode_mobil = kode_mobil
    where
        tbl_petugas_mobil_bonus.kode_petugas = kode_petugas
    ;  
    
    delete
    from
        tbl_merek_mobil_bonus
    where
        TBL_merek_MOBIL_BONUS.KODE_MOBIL = old_kode_mobil
    and
        TBL_merek_MOBIL_BONUS.KODE_MEREK = old_kode_merek
    ;
    
    insert into
    tbl_merek_mobil_bonus
    values
    (
        kode_merek,
        c_kode_mobil
    );
end;


create or replace procedure dl_bonus_petugas(c_kode_transaksi char, c_kode_mobil char)
is
    kode_petugas char(5);
    kode_merek char(10);
begin
    select
        tbl_transaksi.kode_petugas into kode_petugas
    from
        tbl_transaksi
    where
        tbl_transaksi.kode_transaksi = c_kode_transaksi;
    
    select
        tbl_mobil.kode_merek into kode_merek
    from
        tbl_mobil
    where
        tbl_mobil.kode_mobil = c_kode_mobil;
    
    delete
    from
        tbl_petugas_merek_bonus
    where
        TBL_PETUGAS_merek_BONUS.KODE_petugas = kode_petugas
    and
        TBL_PETUGAS_merek_BONUS.KODE_MEREK = kode_merek
    ;
    
    delete
    from
        tbl_petugas_mobil_bonus
    where
        TBL_PETUGAS_MOBIL_BONUS.KODE_petugas = kode_petugas
    and
        TBL_PETUGAS_MOBIL_BONUS.KODE_mobil = c_kode_mobil
    ;
    
    delete
    from
        tbl_merek_mobil_bonus
    where
        TBL_merek_MOBIL_BONUS.KODE_MOBIL = c_kode_mobil
    and
        TBL_merek_MOBIL_BONUS.KODE_MEREK = kode_merek
    ;
end;


drop trigger dl_act_cash;
drop trigger dl_act_kredit;


create or replace procedure hitung_transaksi(kode_transaksi char)
is
    total number;
begin
    total := total_kredit_pertransaksi(kode_transaksi) + total_cash_pertransaksi(kode_transaksi) + total_cicilan_pertransaksi(kode_transaksi);
    count_total_transaksi(kode_transaksi, total);
end;


create or replace function find_angsuran(c_kode_kredit char)
return number
is
    angsuran number;
    harga_mobil number;
    total number;
    c_kode_paket char(10);
    c_kode_mobil char(10);
begin
    select
        tbl_kredit.kode_paket,tbl_kredit.kode_mobil into c_kode_paket, c_kode_mobil
    from
    tbl_kredit
    where
        tbl_kredit.kode_kredit = c_kode_kredit;
        
    select 
        tbl_paket_kredit.biaya_angsuran into angsuran
    from
        tbl_paket_kredit 
    where 
        tbl_paket_kredit.kode_paket = c_kode_paket;
        
    select
        tbl_mobil.harga_mobil into harga_mobil
    from
        tbl_mobil
    where 
        tbl_mobil.kode_mobil = c_kode_mobil;
    
    total := angsuran*harga_mobil;
    return total;
end;


create or replace function find_dp(c_kode_paket char, c_kode_mobil char)
return number
is
    dp number;
    harga_mobil number;
    total number;
begin
    select 
        tbl_paket_kredit.dp into dp
    from
        tbl_paket_kredit 
    where 
        tbl_paket_kredit.kode_paket = c_kode_paket;
        
    select
        tbl_mobil.harga_mobil into harga_mobil
    from
        tbl_mobil
    where 
        tbl_mobil.kode_mobil = c_kode_mobil;
    total := dp*harga_mobil;
    return total;
end;


create or replace function find_h_mobil(c_kode_mobil char)
return number
is
    harga_mobil number;
    total number;
begin
    select 
        tbl_mobil.harga_mobil into harga_mobil 
    from
        tbl_mobil 
    where 
        kode_mobil = c_kode_mobil;
    total := harga_mobil;
    
    return total;
end;

create or replace function total_cash_pertransaksi(kode_transaksi char)
return number
is
    total number;
    cursor c1 is
        select
            tbl_cash.kode_mobil
        from
            tbl_cash
        where
            tbl_cash.kode_transaksi = kode_transaksi;
begin
    total := 0;
    for cash_fetch in c1
    loop
        total := total + find_h_mobil(cash_fetch.kode_mobil);
    end loop;
    return total;
end;


create or replace function total_kredit_pertransaksi(kode_transaksi char)
return number
is
    total number;
    cursor c1 is
        select
            tbl_kredit.kode_mobil, tbl_kredit.kode_paket
        from
            tbl_kredit
        where
            tbl_kredit.kode_transaksi = kode_transaksi;
begin
    total := 0;
    for kredit_fetch in c1
    loop
        total := total + find_dp(kredit_fetch.kode_paket, kredit_fetch.kode_mobil);
    end loop;
    return total;
end;

create or replace function total_cicilan_pertransaksi(kode_transaksi char)
return number
is
    total number;
    cursor c1 is
        select
            tbl_cicilan.kode_kredit
        from
            tbl_cicilan
        where
            tbl_cicilan.kode_transaksi = kode_transaksi;
begin
    total := 0;
    for cicilan_fetch in c1
    loop
        total := total + find_angsuran(cicilan_fetch.kode_kredit);
    end loop;
    return total;
end;
/* end of procedure */


/* Creating triggers */

create or replace trigger uk_petugas
    before insert on tbl_petugas
    for each row
begin
    :new.kode_petugas := 'P'||trim(to_char(:new.kode_petugas));
end;


create or replace trigger uk_transaksi
    before insert on tbl_transaksi
    for each row
begin
    :new.kode_transaksi := 'TRX'||trim(to_char (:new.kode_transaksi));
    :new.total_harga := 0;
end;


create or replace trigger uk_cash
    before insert on tbl_cash
    for each row
    declare
    tgl date;
begin
    :new.kode_cash := 'BCS'||trim(to_char (:new.kode_cash));
    select
        tbl_transaksi.TGL_TRANSAKSI into tgl
    from
        tbl_transaksi
    where
        tbl_transaksi.kode_transaksi = :new.kode_transaksi;
    
    :new.tanggal_cash := tgl;
end;


create or replace trigger uk_kredit
    before insert on tbl_kredit
    for each row
    declare
    sisa_kredit number;
    tgl date;
begin
    :new.kode_kredit := 'BKR'||trim(to_char (:new.kode_kredit));
    
    select
        tbl_paket_kredit.jumlah_angsuran into sisa_kredit
    from
        tbl_paket_kredit
    where
        tbl_paket_kredit.kode_paket = :new.kode_paket;
        
    :new.sisa_kredit := sisa_kredit;
    
    select
        tbl_transaksi.TGL_TRANSAKSI into tgl
    from
        tbl_transaksi
    where
        tbl_transaksi.kode_transaksi = :new.kode_transaksi;
    
    :new.tanggal_kredit := tgl;
    :new.status_kredit := 'belum lunas';
        
    :new.fotocopy_kk := trim(to_char (:new.kode_kredit))||'_fc_kk.jpg';
    :new.fotocopy_ktp := trim(to_char (:new.kode_kredit))||'_fc_ktp.jpg';
    :new.fotocopy_slip_gaji := trim(to_char (:new.kode_kredit))||'_fc_slg.jpg';
end;


create or replace trigger uk_cicilan
    before insert on tbl_cicilan
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
        tbl_kredit.kode_paket, tbl_kredit.sisa_kredit, tbl_kredit.tanggal_kredit  
        from
            tbl_kredit
        where
            tbl_kredit.kode_kredit = :new.kode_kredit;
    
begin
    :new.kode_cicilan := 'CCL'||trim(to_char (:new.kode_cicilan));
    :new.harga_cicilan := find_angsuran(:new.kode_kredit);
    denda :=0;
    
    for kredit_fetch in cukre
    loop
        select
            tbl_paket_kredit.jumlah_angsuran into jumlah_angsuran
        from
            tbl_paket_kredit
        where
            tbl_paket_kredit.kode_paket = kredit_fetch.kode_paket;
            
        sisa_kredit := kredit_fetch.sisa_kredit;
        tanggal_kredit := kredit_fetch.tanggal_kredit;
    end loop;
    cicilan_ke := jumlah_angsuran-sisa_kredit+1;
    jatuh_tempo := add_months(tanggal_kredit,cicilan_ke);
    
    update
        tbl_kredit
    set
        tbl_kredit.sisa_kredit = sisa_kredit-1
    where
        tbl_kredit.kode_kredit = :new.kode_kredit;
    
    select
        tbl_transaksi.tgl_transaksi into tanggal_bayar
    from
        tbl_transaksi
    where
        tbl_transaksi.kode_transaksi = :new.kode_transaksi;
        
    if sisa_kredit <= 1 then
    update
        tbl_kredit
    set
        tbl_kredit.status_kredit = 'lunas'
    where
        tbl_kredit.kode_kredit = :new.kode_kredit;
    
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
    before insert on tbl_merek
    for each row
begin
    :new.kode_merek := 'MRK'||trim(to_char (:new.kode_merek));
end;


create or replace trigger uk_tipe
    before insert on tbl_tipe
    for each row
begin
    :new.kode_tipe := 'T'||trim(to_char (:new.kode_tipe));
end;


create or replace trigger uk_mobil
    before insert on tbl_mobil
    for each row
    declare
        sub_merek char(3);
begin
    select 
        upper(substr(tbl_merek.nama_merek,0,3)) 
        into 
        sub_merek 
    from
        tbl_merek 
    where 
        tbl_merek.kode_merek = :new.kode_merek;
        
    :new.kode_mobil := sub_merek||trim(to_char (:new.kode_mobil));
    :new.gambar := trim(to_char (:new.kode_mobil))||'_pic.jpg';
end;


create or replace trigger uk_paket
    before insert on tbl_paket_kredit
    for each row
begin
    :new.kode_paket := 'PKT'||trim(to_char (:new.kode_paket));
end;


create or replace trigger del_transaksi
    before delete on tbl_transaksi
    for each row
begin
    delete from tbl_cicilan where tbl_cicilan.kode_transaksi = :old.kode_transaksi;
    delete from tbl_cash where tbl_cash.kode_transaksi = :old.kode_transaksi;
    delete from tbl_kredit where tbl_kredit.kode_transaksi = :old.kode_transaksi;
end;


drop trigger UP_ACT_KREDIT;
drop trigger UP_ACT_CASH;

/*
create or replace trigger otosum_in_cash_transkasi
    after insert on tbl_cash
    for each row
begin  
    count_total_transaksi(:new.kode_transaksi, find_h_mobil(:new.kode_mobil));
end;


create or replace trigger otosum_up_cash_transkasi
    after update on tbl_cash
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
    before delete on tbl_cash
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
    after insert on tbl_kredit
    for each row
begin  
    count_total_transaksi(:new.kode_transaksi, find_h_mobil(:new.kode_mobil));
end;


create or replace trigger otosum_up_kredit_transkasi
    after update on tbl_kredit
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
    before delete on tbl_kredit
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


insert into tbl_merek
values(
s_merek.nextVal,
'Honda',
'Jepang'
);

insert into tbl_merek
values(
s_merek.nextVal,
'Suzuki',
'Jepang'
);

insert into tbl_tipe
values(
s_tipe.nextVal,
'MPV'
);

select * from tbl_mobil;

update
    tbl_mobil
set
    tbl_mobil.nama_mobil = 'dudung'
where
    tbl_mobil.kode_mobil = 'HON10019';

insert into tbl_mobil
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

insert into tbl_petugas
values(
s_petugas.nextVal,
'Salim',
'salimin',
'salimsalam.jpg'
);

insert into tbl_customer
values(
'4654543254543',
'ricko',
'jalan. jalan kepasar',
'089674869559'
);

insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas,
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

insert into tbl_kredit
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

insert into tbl_cicilan
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

insert into tbl_paket_kredit
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

insert into tbl_cash
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

delete from tbl_transaksi;

delete from tbl_paket_kredit;

select * from tbl_cicilan;
select * from tbl_kredit;
select * from tbl_cust_mobil_peluang;
select * from tbl_petugas_mobil_bonus;
select * from tbl_merek_mobil_bonus;
select * from tbl_petugas_merek_bonus;
select * from tbl_cust_hari_peluang;
select * from tbl_cash;
select * from tbl_transaksi;
select * from tbl_paket_kredit;
select * from tbl_mobil;
select * from tbl_merek;
select * from tbl_tipe;
select * from tbl_petugas;
select * from tbl_customer;


select * from tbl_petugas;
exec count_total_transaksi('TRX100040',total_cicilan_pertransaksi('TRX100040'));
exec DBMS_OUTPUT.PUT_LINE(find_angsuran('BKR10041'));

exec find_angsuran('BKR10001');
/*SELECT A DAY 
select to_char(to_date(SYSDAT,'dd/mm/yyyy'), 'Day') FROM dual

*/
/*RANDOM SELECT 
select * from (
select NIK from tbl_customer where kode_petugas = '10003' order by dbms_random.value)
where rownum = 1
*/

/*============== DML START HERE=============== */


/* insert petugas */
insert into 
tbl_petugas
(kode_petugas,
nama_petugas,
password,
foto)
values
(
s_petugas.nextVal,
'mamang',
'4lAy',
'gantengs.jpg'
);

insert into 
tbl_petugas
(kode_petugas,
nama_petugas,
password,
foto)
values
(
s_petugas.nextVal,
'Dimas',
'Doszx',
'doszx.jpg'
);


insert into 
tbl_petugas
(kode_petugas,
nama_petugas,
password,
foto)
values
(
s_petugas.nextVal,
'Salim',
'S4lIms',
'Salimin.jpg'
);


insert into 
tbl_petugas
(kode_petugas,
nama_petugas,
password,
foto)
values
(
s_petugas.nextVal,
'Zaid',
'zAiD',
'Zaidunsaleh.jpg'
);


insert into 
tbl_petugas
(kode_petugas,
nama_petugas,
password,
foto)
values
(
s_petugas.nextVal,
'Ahmad',
'AHMAD',
'ahmadun.jpg'
);

/* insert customer */
insert into 
tbl_customer
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
tbl_customer
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
tbl_customer
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
tbl_customer
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
tbl_customer
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
tbl_customer
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
tbl_customer
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
tbl_tipe
(kode_tipe,
nama_tipe)
values
(
s_tipe.nextVal,
'Sport'
);


insert into 
tbl_tipe
(kode_tipe,
nama_tipe)
values
(
s_tipe.nextVal,
'Sedan'
);


insert into 
tbl_tipe
(kode_tipe,
nama_tipe)
values
(
s_tipe.nextVal,
'mobil kota'
);


insert into 
tbl_tipe
(kode_tipe,
nama_tipe)
values
(
s_tipe.nextVal,
'super mini'
);


insert into 
tbl_tipe
(kode_tipe,
nama_tipe)
values
(
s_tipe.nextVal,
'SUV'
);

insert into 
tbl_tipe
(kode_tipe,
nama_tipe)
values
(
s_tipe.nextVal,
'convertible'
);

/* insert merek */
insert into 
tbl_merek
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
tbl_merek
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
tbl_merek
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
tbl_merek
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
tbl_merek
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
tbl_paket_kredit
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
tbl_paket_kredit
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
tbl_paket_kredit
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
tbl_paket_kredit
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
insert into tbl_mobil
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


insert into tbl_mobil
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


insert into tbl_mobil
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


insert into tbl_mobil
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


insert into tbl_mobil
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


insert into tbl_mobil
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


insert into tbl_mobil
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
insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'11155678437623',
to_date('12/05/2015','dd/mm/yyyy'),
'tunai',
'P1122'
);


insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'9375338474827',
to_date('11/11/2016','dd/mm/yyyy'),
'tunai',
'P1123'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'9095123928381       ',
to_date('09/01/2016','dd/mm/yyyy'),
'tunai',
'P1122'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'09493487475834848   ',
to_date('22/07/2016','dd/mm/yyyy'),
'tunai',
'P1100'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'11122233344455      ',
to_date('17/05/2015','dd/mm/yyyy'),
'tunai',
'P1120'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'54564644454212      ',
to_date('19/05/2016','dd/mm/yyyy'),
'tunai',
'P1122'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'11155678437623',
to_date('12/07/2015','dd/mm/yyyy'),
'tunai',
'P1122'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'2015318923823       ',
to_date('12/05/2015','dd/mm/yyyy'),
'tunai',
'P1120'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'11122233344455      ',
to_date('10/02/2016','dd/mm/yyyy'),
'tunai',
'P1123'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'9095123928381       ',
to_date('12/07/2016','dd/mm/yyyy'),
'tunai',
'P1121'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'9375338474827       ',
to_date('12/05/2015','dd/mm/yyyy'),
'tunai',
'P1120'
);

insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'11155678437623',
to_date('12/07/2015','dd/mm/yyyy'),
'tunai',
'P1122'
);


-- next

insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'2015318923823       ',
to_date('28/05/2016','dd/mm/yyyy'),
'tunai',
'P1122'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'11122233344455      ',
to_date('10/08/2016','dd/mm/yyyy'),
'tunai',
'P1120'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'9095123928381       ',
to_date('12/04/2016','dd/mm/yyyy'),
'tunai',
'P1120'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'9375338474827       ',
to_date('10/03/2016','dd/mm/yyyy'),
'tunai',
'P1123'
);

-- next

insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'2015318923823       ',
to_date('28/06/2015','dd/mm/yyyy'),
'tunai',
'P1120'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'11122233344455      ',
to_date('10/09/2016','dd/mm/yyyy'),
'tunai',
'P1123'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'9095123928381       ',
to_date('12/07/2016','dd/mm/yyyy'),
'tunai',
'P1121'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'9375338474827       ',
to_date('25/03/2016','dd/mm/yyyy'),
'tunai',
'P1122'
);

insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'2015318923823       ',
to_date('28/10/2016','dd/mm/yyyy'),
'tunai',
'P1121'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'11122233344455      ',
to_date('20/08/2016','dd/mm/yyyy'),
'tunai',
'P1121'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'9095123928381       ',
to_date('12/01/2016','dd/mm/yyyy'),
'tunai',
'P1121'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'9375338474827       ',
to_date('10/01/2016','dd/mm/yyyy'),
'tunai',
'P1120'
);

insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'2015318923823       ',
to_date('28/05/2016','dd/mm/yyyy'),
'tunai',
'P1123'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'11122233344455      ',
to_date('11/09/2016','dd/mm/yyyy'),
'tunai',
'P1122'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'9095123928381       ',
to_date('12/09/2016','dd/mm/yyyy'),
'tunai',
'P1121'
);




insert into tbl_transaksi
(
kode_transaksi,
NIK,
tgl_transaksi,
jenis_transaksi,
kode_petugas
)
values(
s_transaksi.nextVal,
'9375338474827       ',
to_date('10/11/2016','dd/mm/yyyy'),
'tunai',
'P1121'
);


/* insert kredit */
insert into tbl_kredit
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

exec in_bonus_petugas('TRX100001','MIT10000');
exec in_peluang_cust('TRX100001','MIT10000');

insert into tbl_kredit
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

exec in_bonus_petugas('TRX100021','TOY10027');
exec in_peluang_cust('TRX100021','TOY10027');


insert into tbl_kredit
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

exec in_bonus_petugas('TRX100022','MIT10026');
exec in_peluang_cust('TRX100022','MIT10026');


insert into tbl_kredit
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
exec in_bonus_petugas('TRX100023','FOR10022');
exec in_peluang_cust('TRX100023','FOR10022');


insert into tbl_kredit
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

exec in_bonus_petugas('TRX100023','TOY10027');
exec in_peluang_cust('TRX100023','TOY10027');

/* insert cicilan */
insert into tbl_cicilan
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

insert into tbl_cicilan
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


insert into tbl_cicilan
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


insert into tbl_cicilan
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

insert into tbl_cicilan
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

insert into tbl_cicilan
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


insert into tbl_cicilan
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
insert into tbl_cash
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


insert into tbl_cash
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

exec in_bonus_petugas('TRX100026','TOY10027');
exec in_peluang_cust('TRX100026','TOY10027');


insert into tbl_cash
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

exec in_bonus_petugas('TRX100027','TOY10021');
exec in_peluang_cust('TRX100027','TOY10021');


insert into tbl_cash
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

exec in_bonus_petugas('TRX100028','TOY10022');
exec in_peluang_cust('TRX100028','TOY10022');


insert into tbl_cash
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

exec in_bonus_petugas('TRX100029','FOR10023');
exec in_peluang_cust('TRX100029','FOR10023');


insert into tbl_cash
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

exec in_bonus_petugas('TRX100030','TOY10027');
exec in_peluang_cust('TRX100030','TOY10027');


insert into tbl_cash
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

exec in_bonus_petugas('TRX100029','FOR10022');
exec in_peluang_cust('TRX100029','FOR10022');


insert into tbl_cash
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

exec in_bonus_petugas('TRX100031','TOY10021');
exec in_peluang_cust('TRX100031','TOY10021');


exec hitung_transaksi('TRX100001');
select * from tbl_transaksi;
exec in_bonus_petugas('TRX100001','MIT10000');
exec in_peluang_cust('TRX100001','MIT10000');


create or replace view v_cicilan as select * from tbl_cicilan;
create or replace view v_kredit as select * from tbl_kredit;
create or replace view v_cust_mobil_peluang as select * from tbl_cust_mobil_peluang;
create or replace view v_petugas_mobil_bonus as select * from tbl_petugas_mobil_bonus;
create or replace view v_merek_mobil_bonus as select * from tbl_merek_mobil_bonus;
create or replace view v_petugas_merek_bonus as select * from tbl_petugas_merek_bonus;
create or replace view v_cust_hari_peluang as select * from tbl_cust_hari_peluang;
create or replace view v_cash as select * from tbl_cash;
create or replace view v_transaksi as select * from tbl_transaksi;
create or replace view v_paket_kredit as select * from tbl_paket_kredit;
create or replace view v_mobil as select * from tbl_mobil;
create or replace view v_merek as select * from tbl_merek;
create or replace view v_tipe as select * from tbl_tipe;
create or replace view v_petugas as select * from tbl_petugas;
create or replace view v_customer as select * from tbl_customer;

create or replace view v_trans_pertanggal as select * from tbl_transaksi where tgl_transaksi = to_date('12/05/2015','dd/mm/yyyy');

create or replace view v_trans_perbulan as select * from tbl_transaksi where tgl_transaksi = to_date('12/05/2015','dd/mm/yyyy');
 


