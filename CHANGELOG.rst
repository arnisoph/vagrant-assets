[Unreleased] ([unreleased])
---------------------------
* provide yum/apt proxy support
* update on demand only
* change the location of some salt files, this will break backwards-compat
* rename share/ to shared/
* add /vagrant/shared/modules_ext as additional puppet mod dir
* optionally install hiera-eyaml
* optionally add local tools to PATH
* optionally specify puppet packages to install (e.g. to pin a version)
* Order scripts by numbers instead of characters (#2)
* provide provison step saltstack_provision
* Manage repository sources (#4)

v1.2.0 (2015-04-30)
-------------------
* add puppet_provision provision script
* add pre/post script hooks for provision scripts

v1.1.0 (2015-04-22)
-------------------
* rename saltstack_install_git_arbe to saltstack_install_bootstrap (to make it more generic)
* rename saltstack_install_arbe_git to saltstack_install_git_arbe
* add custom provisioner puppet_install_git
* always install latest DKMS version

v0.1 (2015-03-21)
-----------------
* add script rex_install_dist
* add script rex_install_git
* improve provision scripts
* initial version
