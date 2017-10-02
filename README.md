# 用vagrant安裝一個三台ubuntu 14.04主機的ambari hadoop完整生態圈
## 前言
有鑑於網路上的ambari-vagrant.git這個專案太複雜，因此我把整個ambari安裝的過程簡化到只有3台ubuntu14.04的主機來安裝，下面就是完整的安裝步驟。

## 必要元件

下面是必要的：

* 帶圖型介面的Linux或是Mac OS, Windows不支援
* Firefox/Chrome/Safari瀏覽器 
* 16GB以上的記憶體
* 50G以上的磁碟空間
* git(`sudo apt-get install git`)
* Virtualbox 5.1.0+
* vagrant 2.0.0+

## 檢查軟體版本

vagrant: `vagrant -v`

virtualbox: `vboxmanage -v`

## 下載位址
vagrant<https://www.vagrantup.com/downloads.html>

Virtualbox<https://www.virtualbox.org/wiki/Downloads>

## 前置作業
* `git clone https://github.com/joshhu/ambari-vagrant.git`
* 進入工作目錄，輸入`cd ambari-vagrant`。
* 先將主系統的/etc/hosts修改，加入3台主機，加入的內容參閱```appped-to-etc-hosts.txt```，Linux及Mac系統下要使用root權限才能修改`/etc/hosts`檔案。
* 在專案根目錄下，輸入`./up.sh`啟動三台VM。

## 進入第一台VM主機安裝

* 啟動成功之後，使用`vagrant ssh u1401`進入第一台主機。
* 在第一台VM主機u1401中切換到root權限, `sudo su - `。

## 開始在第一台VM主機u1401中設定安裝Ambari

```ssh
# 加入第一台VM主機中的apt source來源

wget -O /etc/apt/sources.list.d/ambari.list http://public-repo-1.hortonworks.com/ambari/ubuntu14/2.x/updates/2.2.2.0/ambari.list

# 將apt的更新key加入，確定apt source來源是正確的

apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD

# 開始更新來源

apt-get update

# 開始安裝，使用-y參數預設全部問題都是yes

apt-get install ambari-server -y
```

* 安裝完畢後，輸入下面程式安裝
```
ambari-server setup -s #設定Ambari，使用-s就是silent參數，不互動直接使用預設值
ambari-server start #安裝完畢直啟動Ambari Server
```

* 之後進入http://u1401.ambari.apache.org:8080/即可進入圖型安裝介面。
* 預設帳號及密碼admin/admin

### Ambari的安裝

* 建議只安裝```HDFS, MapReduce2, YARN, Tez, Hive Hbase, Pig, Sqoop, ZooKeeper, Ambari Metrics, Spark```即可。
