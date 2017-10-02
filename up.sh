echo `id -u` > .vagrant/machines/u1401/virtualbox/creator_uid
echo `id -u` > .vagrant/machines/u1402/virtualbox/creator_uid
echo `id -u` > .vagrant/machines/u1403/virtualbox/creator_uid
echo `pwd` > .vagrant/machines/u1401/virtualbox/vagrant_cwd
echo `pwd` > .vagrant/machines/u1402/virtualbox/vagrant_cwd
echo `pwd` > .vagrant/machines/u1403/virtualbox/vagrant_cwd
vagrant up u1401
vagrant up u1402
vagrant up u1403
