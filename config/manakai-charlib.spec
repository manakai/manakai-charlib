Name:      manakai-charlib
Summary:   manakai: Extra Character Encodings
Version:   1.0
Release:   1
License:   Perl
Group:     Development/Perl
URL:       http://suika.fam.cx/www/manakai-charlib/readme
Vendor:    Wakaba <w@suika.fam.cx>

BuildRoot: %{_tmppath}/%{name}-%{version}-%(id -u -n)
BuildArch: noarch
Prefix:    %(echo %{_prefix})

Requires:  perl-Encode-GLJIS1978
Requires:  perl-Encode-GLJIS1983
Requires:  perl-Encode-GLJIS1997
Requires:  perl-Encode-GLJIS1997Swapped
Requires:  perl-Encode-EUCJP1997
Requires:  perl-Encode-EUCJP1997OPENNEC
Requires:  perl-Encode-EUCJPSW
Requires:  perl-Encode-ShiftJIS1997

Source0:   manakai-charlib-readme.en.html

%description
The manakai charlib is a product of the manakai project and is
intended to provide supplemental Perl modules to support character
encodings in the wild.

%description -l ja
manakai charlib は manakai プロジェクトのソフトウェアで、
実世界で使われている文字符号化に対応するための補足的な Perl
モジュールを提供しようとしています。

%define htmldir %{_docdir}/%{name}-%{version}

%prep
mkdir -p %{_builddir}/%{name}-%{version}
cd %{_builddir}/%{name}-%{version}
cp %{SOURCE0} ./
chmod -R u+w %{_builddir}/%{name}-%{version}

%build

%install
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

mkdir -p %{buildroot}%{htmldir}
install %{SOURCE0} %{buildroot}%{htmldir}/readme.en.html

%clean
[ "%{buildroot}" != "/" ] && rm -rf %{buildroot}

%files
%doc %{htmldir}/readme.en.html

%changelog
* Mon May  3 2010 Wakaba <w@suika.fam.cx> - 1.0-1
- Initial build.
