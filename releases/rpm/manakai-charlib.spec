Name:      manakai-charlib
Summary:   manakai: Extra Character Encodings
Version:   1.0
Release:   1
License:   Perl
Group:     Development/Perl
URL:       http://suika.fam.cx/www/manakai-charlib/readme
Vendor:    Wakaba <w@suika.fam.cx>

BuildRoot: %{_tmppath}/%{name}-%{version}-%(id -u -n)
BuildArch: x86_64
Prefix:    %(echo %{_prefix})

Requires:  perl-Encode-GLJIS1978
Requires:  perl-Encode-GLJIS1983
Requires:  perl-Encode-GLJIS1997
Requires:  perl-Encode-GLJIS1997Swapped
Requires:  perl-Encode-EUCJP1997
Requires:  perl-Encode-EUCJP1997OPENNEC
Requires:  perl-Encode-EUCJPSW
Requires:  perl-Encode-ShiftJIS1997

%description
The manakai charlib is a product of the manakai project and is
intended to provide supplemental Perl modules to support character
encodings in the wild.

%description -l ja
manakai charlib は manakai プロジェクトのソフトウェアで、
実世界で使われている文字符号化に対応するための補足的な Perl
モジュールを提供しようとしています。

%prep
#%setup -q -n %{pkgname}-%{version} 
mkdir -p %{_builddir}/%{pkgname}-%{version}
chmod -R u+w %{_builddir}/%{pkgname}-%{version}

%build

%install
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

%clean
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

#%files -f %filelist
#%defattr(-,root,root)

%changelog
* Mon May  3 2010 Wakaba <w@suika.fam.cx> - 1.0-1
- Initial build.
