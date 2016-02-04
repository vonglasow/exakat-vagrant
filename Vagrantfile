# -â€‹*- mode: ruby -*â€‹-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

 config.vm.define "default"

 config.vm.box = "debian/jessie64"
#   config.vm.box = "parallels/debian-8.2"
   
 config.vm.hostname = "vagrant-exakat"

 config.vm.provider :virtualbox do |vb|
   vb.gui = false
   vb.customize ["modifyvm", :id, "--memory", "2048", "--cpus", "2"]
 end
 
 config.vm.network "forwarded_port", guest: 7447, host: 7447

 config.vm.provision :ansible do |ansible|
   ansible.verbose = "vvvv"
   ansible.raw_arguments = ['--timeout=300']
   ansible.sudo = true
   ansible.playbook = ".ansible/exakat.yml"
 end
end
