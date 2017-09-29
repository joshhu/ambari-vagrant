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
cd ~/mnt/workspace
./up.sh
```

<http://u1401.ambari.apache.org:8080>


