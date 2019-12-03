# ˵��

��pipeline������BcȺ�����MLST�������ͣ����������������ֵķ��ͣ���Ҫ���и���[���ݿ�](https://pubmlst.org/databases/)�����޸Ľű��еĵ�λ������Ϣ�����нű�ǰ������Ҫע��۲조blastn.ffn.pl���������ļ��ĺ�׺���Ƿ���Լ�������ƥ�䣬����ƥ�䣬��Ҫ�޸Ľű��еĵ�5��7�еġ�.ffn��Ϊ�Լ��ĺ�׺����

```
#!/usr/bin/perl
use strict;
use warnings;

my @fas=glob("*.ffn");
foreach  (@fas) {
	$_=~/(\S+).ffn/;
	my $str = $1 . ".bln";
	system("blastn -query $_ -out $str -db alleles -outfmt 6 -evalue 1e-3 -max_target_seqs 1 -num_threads 6");
}
```

# ��������

## �ļ�׼��

����[MLST profiles](https://pubmlst.org/bigsdb?db=pubmlst_bcereus_seqdef&page=downloadProfiles&scheme_id=1)��������Ϊ��MLST_Profiles.txt����

## �������ݿ�

����Bc Group��[�߸��ܼһ�������](https://pubmlst.org/bigsdb?db=pubmlst_bcereus_seqdef&page=downloadAlleles)���ϲ���һ���ļ���alleles.fa�������������ݿ�

```
makeblastdb -in alleles.fa -out alleles -dbtype nucl
```

����alleles.nhr������alleles.nin������alleles.nsq������MLST_Profiles.txt���Լ�����perl�ű�����������Ŀ¼��

## Blast�ȶԵ�λ���򲢻�ȡ��λ������/����

�Ի������scaffold/��������Ϊquery����ܼһ���⡰alleles���ȶԡ�

- (A) ������Ϊ��NCBI���صĻ����飬�����С�NCBI/GENOME���еĽű�

```
perl blastn.ffn.pl
getST.v7.pl
```

- (B) ������Ϊ��NCBI���صĻ������У������С�NCBI/CDS���еĽű�

```
perl blastn.ffn.pl
getST.v6.pl
```

- (C) ��Ϊ�Լ���������ݣ�������л�������װ�ͻ���Ԥ��(ԭ�������������װ������Ԥ�����[PGCGAP](https://github.com/liaochenlanruo/pgcgap)���)���Ի�������Ϊquery�����С�Others���еĽű�

```
perl blastn.ffn.pl
getST.v4.pl
```

## ��ȡ������(ST)

```
perl add.ST_type.pl
```
