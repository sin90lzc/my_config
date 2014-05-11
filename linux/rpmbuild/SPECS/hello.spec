#rpmbuild -ba spec的执行顺序是%prep->%build->%install->%install->%clean
#宏定义
%define softname hello
%define softver 1.0
#软件包的名称，有了这个名称就可以使用rpm -q hello来查询该软件包咯
#最后生成的rpm包名命名是${name}-${version}-${release}-${arch}.rpm
Name:		%{softname}
#版本号
Version:	%{softver}
#发布包名,?dist表示uname -r中的倒数第2个点区
Release:	1%{?dist}
#概述了
Summary:	hello world rpm

#这个没啥用，随便填
Group:		hello
#许可证书
License:	GPL
#官方地址
URL:		http://blog.csdn.com/sin90lzc
#源码包名称了
Source0:	%{name}-%{version}.tar.gz	
#这个在实际上起了什么作用呢，反正没看到有生成这样的文件夹
#刚发现%{_tmppath}对应的是/var/tmp目录了，但好像真的没用，真想把它屏蔽掉
BuildRoot:	%(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXX)

#在build的过程中需要信赖什么软件
BuildRequires:	/usr/bin/gcc
#软件的运行需要信赖什么软件
Requires:	telnet >= 0.1

#软件包的描述信息
%description
hello world program

#准备阶段，一般就是把源代码的压缩包解压后放到BUILD目录下
%prep
%setup -q

#构建阶段，在此阶段，工作目录是BUILD/{source},{source}表示解压源码包的目录
%build
make

#安装阶段，安装阶段是指在%{buildroot}目录下部署好要安装的文件而已，不是指安装到当前主机。
#%{buildroot}对应的是BUILDROOT/{package-name},这里的package-name与最后生成的rpm包名一样。
%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/usr/local/bin
mkdir -p %{buildroot}/usr/local/share/man/man1
make install INSTALL_PATH=%{buildroot}

#清理阶段
%clean
rm -rf %{buildroot}

#文件列表
%files
/usr/local/bin/sayhello
/usr/local/share/man/man1/sayhello.1
%defattr(-,root,root,-)
%doc /usr/local/share/man/man1/sayhello.1
%attr(0755,root,root)/usr/local/bin/sayhello




#更新日志，注意格式
#* 日期 姓名 <邮箱> 版本号
#- 描述
%changelog
* Wed Nov 8 2013 tim leung <lzcgame@gmail.com> 1.0
- my first hello world rpm

#这里定义准备安装（这里是真的安装了）前执行的脚本
%pre
echo "prepare to install..."

#这里定义在安装后执行的脚本
%post
echo "after install..."

#这里定义在卸载前执行的脚本
%preun
echo "prepare to uninstall..."

#这里定义在卸载后执行的脚本
%postun
echo "after uninstall..."
