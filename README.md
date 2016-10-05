ambari-vagrant
==============

精簡化的ambari-vagrant，只使用centos6.4而已。

指令集：

cd ~

#下載自製好的Ambari-vagrant設定檔

git clone https://github.com/joshhu/ambari-vagrant.git

#更改dns記錄

cat /etc/hosts
cd ambari-vagrant
sudo vim /etc/hosts append-to-etc-hosts.txt

#複製本機的ssh key

cp ~/.vagrand.d/insecure_private_key .

#啟動第一台vm

vagrant up c6401

#檢查啟動狀態

vagrant status

#正常的話，就啟動第二、三台

vagrant up c6402
vagrant up c6403

#還是不要忘了檢查第二、三台，如果沒有啟動，要再啟動一次

vagrant status

#啟動之後，執行防火牆關閉

vagrant reload --provision

#測試dns是否有通

ping c6401
ping c6402
ping c6403

#進入第一台安裝ambari

vagrant ssh c6401
sudo su -
wget -O /etc/yum.repos.d/ambari.repo http://public-repo-1.hortonworks.com/ambari/centos6/2.x/updates/2.2.2.0/ambari.repo
yum install ambari-server -y

#設定Ambari，記住這邊是使用root身份啟動的。  w

ambari-server setup -s
ambari-server start


#之後離開虛擬機，並且測試是否有被防火牆檔

curl c6401:8080

#如果有被擋，就再執行一次

vagrant reload --provision

#正常之後，就直接進入瀏覽器開始設定，可以參考之後的ppt
