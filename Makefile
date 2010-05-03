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

GLJIS1978 GLJIS1983 GLJIS1997: GLJIS%: $(UCM_DIR)gl-jis-%.ucm
	$(MKDIR) -p $@
	$(CP) $< $@/$(<:$(UCM_DIR)%=%)
	$(CD) $@ && $(ENC2XS) -M $@ $(<:$(UCM_DIR)%=%)
	$(CD) $@ && $(PERL_) ./Makefile.PL
	$(CD) $@ && $(MAKE) manifest dist
GLJIS1997Swapped: $(UCM_DIR)gl-jis-1997-swapped.ucm
	$(MKDIR) -p $@
	$(CP) $< $@/$(<:$(UCM_DIR)%=%)
	$(CD) $@ && $(ENC2XS) -M $@ $(<:$(UCM_DIR)%=%)
	$(CD) $@ && $(PERL_) ./Makefile.PL
	$(CD) $@ && $(MAKE) manifest dist
EUCJP1997: $(UCM_DIR)euc-jp-1997.ucm
	$(MKDIR) -p $@
	$(CP) $< $@/$(<:$(UCM_DIR)%=%)
	$(CD) $@ && $(ENC2XS) -M $@ $(<:$(UCM_DIR)%=%)
	$(CD) $@ && $(PERL_) -i -p -e 's/"0\.01"/"0.02"/' $@.pm
	$(CD) $@ && $(PERL_) ./Makefile.PL
	$(CD) $@ && $(MAKE) manifest dist
EUCJP1997OPENNEC: $(UCM_DIR)euc-jp-1997-open-nec.ucm
	$(MKDIR) -p $@
	$(CP) $< $@/$(<:$(UCM_DIR)%=%)
	$(CD) $@ && $(ENC2XS) -M $@ $(<:$(UCM_DIR)%=%)
	$(CD) $@ && $(PERL_) ./Makefile.PL
	$(CD) $@ && $(MAKE) manifest dist
EUCJPSW: $(UCM_DIR)euc-jp-sw.ucm
	$(MKDIR) -p $@
	$(CP) $< $@/$(<:$(UCM_DIR)%=%)
	$(CD) $@ && $(ENC2XS) -M $@ $(<:$(UCM_DIR)%=%)
	$(CD) $@ && $(PERL_) ./Makefile.PL
	$(CD) $@ && $(MAKE) manifest dist
ShiftJIS1997: $(UCM_DIR)shift-jis-1997.ucm
	$(MKDIR) -p $@
	$(CP) $< $@/$(<:$(UCM_DIR)%=%)
	$(CD) $@ && $(ENC2XS) -M $@ $(<:$(UCM_DIR)%=%)
	$(CD) $@ && $(PERL_) ./Makefile.PL
	$(CD) $@ && $(MAKE) manifest dist

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
