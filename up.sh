echo `id -u` > .vagrant/machines/u1401/virtualbox/creator_uid
echo `id -u` > .vagrant/machines/u1402/virtualbox/creator_uid
echo `id -u` > .vagrant/machines/u1403/virtualbox/creator_uid

vagrant up u1401
vagrant up u1402
vagrant up u1403
