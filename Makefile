## TO UPDATE: make all release-update distclean

CD = cd
CAT = cat
MKDIR = mkdir
MAKE = make
RM = rm
RMALL = $(RM) -fv
RMDIRALL = $(RMALL) -r
PERL = perl
PERL_OPTIONS =
PERL_OPTIONS_ALL = $(PERL_OPTIONS)
PERL_ = $(PERL) $(PERL_OPTIONS_ALL)
PERLC = $(PERL) -c -w
PERLC_OPTIONS = 
PERLC_OPTIONS_ALL = $(PERLC_OPTIONS) 
PERL_CHK = $(PERLC) $(PERLC_OPTIONS_ALL)
TOUCH = touch
GREP = grep
GREPV = $(GREP) -v
PERL_INPLACE = $(PERL_) -n -i
ECHO = echo
CP = cp
MV = mv

ENC2XS_PATH = 
ENC2XS = $(ENC2XS_PATH)enc2xs

UCM_DIR = modules/chartables/generated/

ENCODE_DIRECTORIES = \
  GLJIS1978 GLJIS1983 GLJIS1997 GLJIS1997Swapped EUCJP1997 ShiftJIS1997 \
  EUCJP1997OPENNEC EUCJPSW

GENERATED_FILES = $(PM_FILES)

all: $(ENCODE_DIRECTORIES)

GLJIS1978: $(UCM_DIR)gl-jis-1978.ucm Makefile
	make subdir SUBDIR_DIRNAME=$@ SUBDIR_SOURCE=$< SUBDIR_VERSION=0.02 \
	  SUBDIR_ENCODE_NAME=gl-jis-1978
GLJIS1983: $(UCM_DIR)gl-jis-1978.ucm Makefile
	make subdir SUBDIR_DIRNAME=$@ SUBDIR_SOURCE=$< SUBDIR_VERSION=0.02 \
	  SUBDIR_ENCODE_NAME=gl-jis-1983
GLJIS1997: $(UCM_DIR)gl-jis-1978.ucm Makefile
	make subdir SUBDIR_DIRNAME=$@ SUBDIR_SOURCE=$< SUBDIR_VERSION=0.02 \
	  SUBDIR_ENCODE_NAME=gl-jis-1997
GLJIS1997Swapped: $(UCM_DIR)gl-jis-1997-swapped.ucm Makefile
	make subdir SUBDIR_DIRNAME=$@ SUBDIR_SOURCE=$< SUBDIR_VERSION=0.02 \
	  SUBDIR_ENCODE_NAME=gl-jis-1997-swapped
EUCJP1997: $(UCM_DIR)euc-jp-1997.ucm Makefile
	make subdir SUBDIR_DIRNAME=$@ SUBDIR_SOURCE=$< SUBDIR_VERSION=0.03 \
	  SUBDIR_ENCODE_NAME=euc-jp-1997
EUCJP1997OPENNEC: $(UCM_DIR)euc-jp-1997-open-nec.ucm Makefile
	make subdir SUBDIR_DIRNAME=$@ SUBDIR_SOURCE=$< SUBDIR_VERSION=0.02 \
	  SUBDIR_ENCODE_NAME=euc-jp-1997-open-nec
EUCJPSW: $(UCM_DIR)euc-jp-sw.ucm Makefile
	make subdir SUBDIR_DIRNAME=$@ SUBDIR_SOURCE=$< SUBDIR_VERSION=0.02 \
	  SUBDIR_ENCODE_NAME=euc-jp-sw
ShiftJIS1997: $(UCM_DIR)shift-jis-1997.ucm Makefile
	make subdir SUBDIR_DIRNAME=$@ SUBDIR_SOURCE=$< SUBDIR_VERSION=0.02 \
	  SUBDIR_ENCODE_NAME=shift-jis-1997

subdir: Makefile
	$(MKDIR) -p $(SUBDIR_DIRNAME)
	$(CP) $(SUBDIR_SOURCE) $(SUBDIR_DIRNAME)/$(SUBDIR_SOURCE:$(UCM_DIR)%=%)
	$(CD) $(SUBDIR_DIRNAME) && $(ENC2XS) -M $(SUBDIR_DIRNAME) $(SUBDIR_SOURCE:$(UCM_DIR)%=%)
	$(RM) $(SUBDIR_DIRNAME)/Changes
	$(RM) $(SUBDIR_DIRNAME)/README
	$(CD) $(SUBDIR_DIRNAME) && $(PERL_) -i -p -e 's/"0\.01"/"$(SUBDIR_VERSION)"/' $(SUBDIR_DIRNAME).pm
	$(CD) $(SUBDIR_DIRNAME) && $(PERL_) -i -p -0 -e 's{__END__.*}{qq{join "\n", \
		"__END__", \
		"", \
		"=head1 NAME", \
		"", \
		"Encode::$(SUBDIR_DIRNAME) - Encode module for the charset C<$(SUBDIR_ENCODE_NAME)>", \
		"", \
		"=head1 SYNOPSIS", \
		"", \
		"  use Encode;", \
		"  use Encode::$(SUBDIR_DIRNAME);", \
		"  my \\x24bytes = encode \\x27$(SUBDIR_ENCODE_NAME)\\x27, \\x24chars;", \
		"  my \\x24chars = decode \\x27$(SUBDIR_ENCODE_NAME)\\x27, \\x24bytes;", \
		"", \
		"=head1 SEE ALSO", \
		"", \
		"manakai-charlib <http://suika.fam.cx/www/manakai-charlib/readme>.", \
		"", \
		"=head1 AUTHOR", \
		"", \
		"Wakaba <w\\x40suika.fam.cx>.", \
		"", \
		"=head1 LICENSE", \
		"", \
		"Copyright 2006-2010 Wakaba <w\\x40suika.fam.cx>.", \
		"", \
		"This library is free software; you can redistribute it and/or modify", \
		"it under the same terms as Perl itself.", \
		"", \
        }}see' $(SUBDIR_DIRNAME).pm
	$(CD) $(SUBDIR_DIRNAME) && $(PERL_) -i -p -e 's/WriteMakefile\(/WriteMakefile\( \
		ABSTRACT_FROM => "$(SUBDIR_DIRNAME).pm", \
		AUTHOR => "Wakaba <w".chr(0x40)."suika.fam.cx>", \
		LICENSE => "Perl", \
	/' Makefile.PL
	$(CD) $(SUBDIR_DIRNAME) && $(PERL_) ./Makefile.PL
	$(CD) $(SUBDIR_DIRNAME) && $(MAKE) manifest dist

release-update: \
    GLJIS1978 GLJIS1983 GLJIS1997 GLJIS1997Swapped \
    EUCJP1997 EUCJP1997OPENNEC EUCJPSW ShiftJIS1997
	$(MV) GLJIS1978/Encode-GLJIS1978-0.01.tar.gz ./
	$(MV) GLJIS1983/Encode-GLJIS1983-0.01.tar.gz ./
	$(MV) GLJIS1997/Encode-GLJIS1997-0.01.tar.gz ./
	$(MV) GLJIS1997Swapped/Encode-GLJIS1997Swapped-0.01.tar.gz ./
	$(MV) EUCJP1997/Encode-EUCJP1997-0.02.tar.gz ./
	$(MV) EUCJP1997OPENNEC/Encode-EUCJP1997OPENNEC-0.01.tar.gz ./
	$(MV) EUCJPSW/Encode-EUCJPSW-0.01.tar.gz ./
	$(MV) ShiftJIS1997/Encode-ShiftJIS1997-0.01.tar.gz ./

clean-GLJIS1978 clean-GLJIS1983 clean-GLJIS1997 clean-GLJIS1997Swapped \
  clean-EUCJP1997 clean-EUCJP1997OPENNEC clean-EUCJPSW \
  clean-ShiftJIS1997: clean-%: %
	$(CD) $< && $(MAKE) clean

clean: clean-GLJIS1978 clean-GLJIS1983 clean-GLJIS1997 \
  clean-GLJIS1997Swapped \
  clean-EUCJP1997 clean-EUCJP1997OPENNEC clean-EUCJPSW clean-ShiftJIS1997
	$(RMALL) .*.tmp *~ .*~ *.BAK .*.BAK

clean-subdirectories:
	$(RMDIRALL) $(ENCODE_DIRECTORIES)

distclean: clean-subdirectories
	$(RMALL) .*.tmp *~ .*~ *.BAK .*.BAK

## License: Public Domain.
