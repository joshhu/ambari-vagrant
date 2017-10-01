# 用vagrant安裝一個三台ubuntu 14.04主機的ambari hadoop+spark
## 前言
有鑑於網路上的ambari-vagrant.git這個專案太複雜，因此我把整個ambari安裝的過程簡化到只有3台ubuntu14.04的主機來安裝，下面就是完整的安裝步驟。

## 必要元件

下面是必要的：

* 帶圖型介面的Linux或是Mac OS(不推薦Windows)
* git
* Virtualbox
* vagrant

## for中原大學資管同學

<https://www.vagrantup.com/downloads.html>
```
sudo rm -rf /usr/local/bin/vagrant
sudo rm -rf /var/lib/gems/2.3.0/gems/vagrant-1.5.0/
cd ~
dkpg -i vagrant_2.0.0_x86_64.deb


sudo mount /dev/sdb ~/mnt
sudo chown -R ubuntu:ubuntu mnt/
cd mnt
mkdir workspace
mkdir VMs
cd mnt
mkdir VMs
mkdir workspace

vboxmanage setproperty machinefolder ~/mnt/VMs
```


## 安裝
* `git clone https://github.com/joshhu/ambari-vagrant.git`
* 先將主系統的/etc/hosts修改，加入3台主機，加入的內容參閱```appped-to-etc-hosts.txt```，Linux及Mac系統下要使用root權限。
* 先clone這個git，然後在專案根目錄下，輸入```./up.sh```啟動三台VM。
* 執行`cp ~/.vagrant.d/insecured_key .`
* 啟動成功之後，使用```vagrant ssh u1401```進入第一台主機。
* 切換到root權限開始安裝

```
sudo su -
wget -O /etc/apt/sources.list.d/ambari.list http://public-repo-1.hortonworks.com/ambari/ubuntu14/2.x/updates/2.2.2.0/ambari.list
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD
apt-get update
apt-get install ambari-server -y
```

* 安裝完畢後，輸入下面程式安裝
```
ambari-server setup -s
ambari-server start
```

* 之後進入http://u1401:8080/即可進入介面。
* 預設帳號及密碼admin/admin

### Ambari的安裝

* 建議只安裝```HDFS, MapReduce2, YARN, Tez, Hive Hbase, Pig, Sqoop, ZooKeeper, Ambari Metrics, Spark```即可。
 
## 20171001 Hadoop課程

<https://github.com/joshhu/ambari-vagrant>

### 先別忘了將d磁碟掛載到系統中
```
sudo mount /dev/sdb ~/mnt
```

### 啟動三台節點的Ambari叢集

```
cd ~/mnt/workspace/ambari-vagrant/
./up.sh
```

<http://u1401.ambari.apache.org:8080>

### 讓spark能使用hive view

先建立spark使用者對應到系統，用spark登入，然後在hdfs->config->advanced->custom core-site，加入兩筆記錄
```
hadoop.proxyuser.root.groups *
hadoop.proxyuser.root.hosts *
```
存檔後重啟所有受影響服務。

### 下載範例資料

大聯盟：Batting.csv
航  班：2008.csv
計程車：taxi.csv

### hive程式碼

建立資料庫
```
create database bigdata;
```

建立表
```
use bigdata;
create table bigdata.batting
(playerID STRING, yearID STRING, stint INT, teamID STRING, lgID STRING, G INT, AB INT, R INT, H INT, twoB INT, threeB INT, HR INT, RBI INT, SB INT, CS INT, BB INT, SO INT, IBB INT, HBP INT, SH INT, SF INT, GIDP INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' tblproperties("skip.header.line.count"="1"); 
```

檢查表格是否建立成功
```
use bigdata;
select * from batting;
```


載入外部檔案
```
use bigdata;
LOAD DATA INPATH '/user/spark/Batting.csv' OVERWRITE INTO TABLE bigdata.batting;
```

列出2010年後打擊率最高的選手(必須滿足100個打數以上)
```
use bigdata;
select playerID, yearID, ab, h, twob, threeb, hr, (h/ab)* 10 Rate from Batting where ab >= 100 and yearid >2010 order by Rate desc;
```

## Spark python程式

先下載Anaconda並安裝
```
wget https://repo.continuum.io/archive/Anaconda3-5.0.0-Linux-x86_64.sh
chmod +x Anaconda3-5.0.0-Linux-x86_64.sh
./Anaconda3-5.0.0-Linux-x86_64.sh
```

### 建立一個python2.7的環境給Spark用
```
conda create -n py27 python=2.7 anaconda
source activate py27
jupyter notebook --ip=<你的u1401的ip>
```
此時只能執行jupyter notebook, 但還不能執行pyspark

在你的.bashrc中加入下面三行
```
unset XDG_RUNTIME_DIR
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook'
```

啟動pyspark時就直接進入jupyter, 但是用localhost，因此還要指定ip

先建立jupyter notebook的設定檔
```
jupyter notebook --generate-config
```

修改.jupyter下的設定檔，把ip改為你主機的ip，修改項目為
c.NotebookApp.ip = <u1401>的ip

下次啟動pyspark時，就可以直接進入notebook並且可以指定ip進入。
