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

BIN_DIR = modules/chartables/bin/
TBR_DIR = modules/chartables/source/
TBL_DIR = modules/chartables/generated/
EUCTBL_DIR = modules/chartables/eucjp/
CPTBR_DIR = modules/chartables/cp/

TBR2TBL_PL = $(BIN_DIR)tbr2tbl.pl
TBR2TBL = $(PERL_) $(TBR2TBL_PL)

TBL2UCM_PL = $(BIN_DIR)tbl2ucm.pl
TBL2UCM = $(PERL_) $(TBL2UCM_PL)

GL_JIS_TBR_FILES = $(TBR_DIR)gl-jisx0208-common.tbr $(TBR_DIR)gl-cjk-hiragana.tbr \
  $(TBR_DIR)gl-cjk-katakana.tbr $(TBR_DIR)gl-cjk-greek.tbr $(TBR_DIR)gl-cjk-cyrillic.tbr \
  $(TBR_DIR)gl-iso-646-alphanumeric.tbr $(TBR_DIR)gl-cjk-box-drawing.tbr
GENERATED_TBR_FILES = euc-jp-1997.tbr shift-jis-1997.tbr \
  gl-jis-1978.tbr gl-jis-1983.tbr gl-jis-1997.tbr gl-jis-1997-swapped.tbr
TBR_FILES = $(GL_JIS_TBR_FILES) $(GENERATED_TBR_FILES) \
  gl-iso-646-alphanumeric-fw.tbr gl-iso-646-symbol.tbr \
  gl-jisx0212-common.tbr jisx0208_1997.tbr

TBL_FILES = $(GENERATED_TBR_FILES:.tbr=.tbl)

UCM_FILES = $(GENERATED_TBR_FILES:.tbr=.ucm)

ENCODE_DIRECTORIES = \
  GLJIS1978 GLJIS1983 GLJIS1997 GLJIS1997Swapped EUCJP1997 ShiftJIS1997 \
  EUCJP1997OPENNEC EUCJPSW

GENERATED_FILES = $(PM_FILES)

all: $(ENCODE_DIRECTORIES)

gl-jis-1997.tbr: $(TBR_DIR)jisx0208_1997.tbr $(GL_JIS_TBR_FILES) \
  $(TBR_DIR)gl-iso-646-symbol.tbr $(TBR2TBL_PL)
	$(TBR2TBL) $< > $@
	$(PERL_INPLACE) -e 'print unless /^#(?!\?PETBL)/' $@
	$(ECHO) '#?o name="gl-jis-1997"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="2"' >> $@
	$(ECHO) '#?o license="Public Domain"' >> $@

gl-jis-1997-swapped.tbr: gl-jis-1997.tbr
	$(CP) $< $@
	$(PERL_INPLACE) -e 'print unless /^#(?!\?PETBL)/' $@
	$(PERL_INPLACE) -e 'print unless /^0x(?:3033|724D|3229|7274|3342|695A|3349|5978|3376|635E|3443|5E75|3452|6B5D|375B|7074|395C|6268|3C49|6922|3F59|7057|4128|6C4D|445B|5464|4557|626A|456E|5B6D|4573|5E39|4676|6D6E|4768|6A24|4930|5B58|4B79|5056|4C79|692E|4F36|6446|3646|4B6A|4D5A|6076|742[1234])/' $@
	$(ECHO) '0x3033	U+9C3A		# <cjk>' >> $@
	$(ECHO) '0x724D	U+9BF5		# <cjk>' >> $@
	$(ECHO) '0x3229	U+9DAF		# <cjk>' >> $@
	$(ECHO) '0x7274	U+9D2C		# <cjk>' >> $@
	$(ECHO) '0x3342	U+8823		# <cjk>' >> $@
	$(ECHO) '0x695A	U+86CE		# <cjk>' >> $@
	$(ECHO) '0x3349	U+652A		# <cjk>' >> $@
	$(ECHO) '0x5978	U+64B9		# <cjk>' >> $@
	$(ECHO) '0x3376	U+7AC8		# <cjk>' >> $@
	$(ECHO) '0x635E	U+7AC3		# <cjk>' >> $@
	$(ECHO) '0x3443	U+704C		# <cjk>' >> $@
	$(ECHO) '0x5E75	U+6F45		# <cjk>' >> $@
	$(ECHO) '0x3452	U+8AEB		# <cjk>' >> $@
	$(ECHO) '0x6B5D	U+8ACC		# <cjk>' >> $@
	$(ECHO) '0x375B	U+9838		# <cjk>' >> $@
	$(ECHO) '0x7074	U+981A		# <cjk>' >> $@
	$(ECHO) '0x395C	U+7926		# <cjk>' >> $@
	$(ECHO) '0x6268	U+783F		# <cjk>' >> $@
	$(ECHO) '0x3C49	U+8602		# <cjk>' >> $@
	$(ECHO) '0x6922	U+854A		# <cjk>' >> $@
	$(ECHO) '0x3F59	U+9771		# <cjk>' >> $@
	$(ECHO) '0x7057	U+976D		# <cjk>' >> $@
	$(ECHO) '0x4128	U+8CE4		# <cjk>' >> $@
	$(ECHO) '0x6C4D	U+8CCE		# <cjk>' >> $@
	$(ECHO) '0x445B	U+58FA		# <cjk>' >> $@
	$(ECHO) '0x5464	U+58F7		# <cjk>' >> $@
	$(ECHO) '0x4557	U+792A		# <cjk>' >> $@
	$(ECHO) '0x626A	U+783A		# <cjk>' >> $@
	$(ECHO) '0x456E	U+6AAE		# <cjk>' >> $@
	$(ECHO) '0x5B6D	U+68BC		# <cjk>' >> $@
	$(ECHO) '0x4573	U+6FE4		# <cjk>' >> $@
	$(ECHO) '0x5E39	U+6D9B		# <cjk>' >> $@
	$(ECHO) '0x4676	U+9087		# <cjk>' >> $@
	$(ECHO) '0x6D6E	U+8FE9		# <cjk>' >> $@
	$(ECHO) '0x4768	U+8805		# <cjk>' >> $@
	$(ECHO) '0x6A24	U+877F		# <cjk>' >> $@
	$(ECHO) '0x4930	U+6A9C		# <cjk>' >> $@
	$(ECHO) '0x5B58	U+6867		# <cjk>' >> $@
	$(ECHO) '0x4B79	U+5118		# <cjk>' >> $@
	$(ECHO) '0x5056	U+4FAD		# <cjk>' >> $@
	$(ECHO) '0x4C79	U+85EA		# <cjk>' >> $@
	$(ECHO) '0x692E	U+85AE		# <cjk>' >> $@
	$(ECHO) '0x4F36	U+7C60		# <cjk>' >> $@
	$(ECHO) '0x6446	U+7BED		# <cjk>' >> $@
	$(ECHO) '0x3646	U+582F		# <cjk>' >> $@
	$(ECHO) '0x4B6A	U+69C7		# <cjk>' >> $@
	$(ECHO) '0x4D5A	U+9059		# <cjk>' >> $@
	$(ECHO) '0x6076	U+7464		# <cjk>' >> $@
	$(ECHO) '0x7421	U+5C2D		# <cjk>' >> $@
	$(ECHO) '0x7422	U+69D9		# <cjk>' >> $@
	$(ECHO) '0x7423	U+9065		# <cjk>' >> $@
	$(ECHO) '0x7424	U+7476		# <cjk>' >> $@
	$(ECHO) '#?o name="gl-jis-1997-swapped"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="2"' >> $@
	$(ECHO) '#?o license="Public Domain"' >> $@

gl-jis-1983.tbr: gl-jis-1997.tbr
	$(CP) $< $@
	$(PERL_INPLACE) -e 'print unless /^#(?!\?PETBL)/' $@
	$(PERL_INPLACE) -e 'print unless /^0x742[56]/' $@
	$(ECHO) '#?o name="gl-jis-1983"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="2"' >> $@
	$(ECHO) '#?o license="Public Domain"' >> $@

gl-jis-1978.tbr: gl-jis-1983.tbr
	$(CP) $< $@
	$(PERL_INPLACE) -e 'print unless /^#(?!\?PETBL)/' $@
	$(PERL_INPLACE) -e 'print unless /^0x(?:3033|724D|3229|7274|3342|695A|3349|5978|3376|635E|3443|5E75|3452|6B5D|375B|7074|395C|6268|3C49|6922|3F59|7057|4128|6C4D|445B|5464|4557|626A|456E|5B6D|4573|5E39|4676|6D6E|4768|6A24|4930|5B58|4B79|5056|4C79|692E|4F36|6446|3646|4B6A|4D5A|6076)/' $@
	$(PERL_INPLACE) -e 'print unless /^0x(?:2(?:2[3-7]|8)|3022|316B|322A|337A|3622|366D|3834|396D|3C48|3D2B|3E5[5F]|4066|415F|424D|433D|444F|453[6F]|4578|4642|4739|482E|4830|4B4B|4C4D|4D69|4F39|5A39|74)/' $@
	$(ECHO) '0x3033	U+9C3A		# <cjk>' >> $@
	$(ECHO) '0x724D	U+9BF5		# <cjk>' >> $@
	$(ECHO) '0x3229	U+9DAF		# <cjk>' >> $@
	$(ECHO) '0x7274	U+9D2C		# <cjk>' >> $@
	$(ECHO) '0x3342	U+8823		# <cjk>' >> $@
	$(ECHO) '0x695A	U+86CE		# <cjk>' >> $@
	$(ECHO) '0x3349	U+652A		# <cjk>' >> $@
	$(ECHO) '0x5978	U+64B9		# <cjk>' >> $@
	$(ECHO) '0x3376	U+7AC8		# <cjk>' >> $@
	$(ECHO) '0x635E	U+7AC3		# <cjk>' >> $@
	$(ECHO) '0x3443	U+704C		# <cjk>' >> $@
	$(ECHO) '0x5E75	U+6F45		# <cjk>' >> $@
	$(ECHO) '0x3452	U+8AEB		# <cjk>' >> $@
	$(ECHO) '0x6B5D	U+8ACC		# <cjk>' >> $@
	$(ECHO) '0x375B	U+9838		# <cjk>' >> $@
	$(ECHO) '0x7074	U+981A		# <cjk>' >> $@
	$(ECHO) '0x395C	U+7926		# <cjk>' >> $@
	$(ECHO) '0x6268	U+783F		# <cjk>' >> $@
	$(ECHO) '0x3C49	U+8602		# <cjk>' >> $@
	$(ECHO) '0x6922	U+854A		# <cjk>' >> $@
	$(ECHO) '0x3F59	U+9771		# <cjk>' >> $@
	$(ECHO) '0x7057	U+976D		# <cjk>' >> $@
	$(ECHO) '0x4128	U+8CE4		# <cjk>' >> $@
	$(ECHO) '0x6C4D	U+8CCE		# <cjk>' >> $@
	$(ECHO) '0x445B	U+58FA		# <cjk>' >> $@
	$(ECHO) '0x5464	U+58F7		# <cjk>' >> $@
	$(ECHO) '0x4557	U+792A		# <cjk>' >> $@
	$(ECHO) '0x626A	U+783A		# <cjk>' >> $@
	$(ECHO) '0x456E	U+6AAE		# <cjk>' >> $@
	$(ECHO) '0x5B6D	U+68BC		# <cjk>' >> $@
	$(ECHO) '0x4573	U+6FE4		# <cjk>' >> $@
	$(ECHO) '0x5E39	U+6D9B		# <cjk>' >> $@
	$(ECHO) '0x4676	U+9087		# <cjk>' >> $@
	$(ECHO) '0x6D6E	U+8FE9		# <cjk>' >> $@
	$(ECHO) '0x4768	U+8805		# <cjk>' >> $@
	$(ECHO) '0x6A24	U+877F		# <cjk>' >> $@
	$(ECHO) '0x4930	U+6A9C		# <cjk>' >> $@
	$(ECHO) '0x5B58	U+6867		# <cjk>' >> $@
	$(ECHO) '0x4B79	U+5118		# <cjk>' >> $@
	$(ECHO) '0x5056	U+4FAD		# <cjk>' >> $@
	$(ECHO) '0x4C79	U+85EA		# <cjk>' >> $@
	$(ECHO) '0x692E	U+85AE		# <cjk>' >> $@
	$(ECHO) '0x4F36	U+7C60		# <cjk>' >> $@
	$(ECHO) '0x6446	U+7BED		# <cjk>' >> $@
	$(ECHO) '0x3646	U+582F		# <cjk>' >> $@
	$(ECHO) '0x4B6A	U+69C7		# <cjk>' >> $@
	$(ECHO) '0x4D5A	U+9059		# <cjk>' >> $@
	$(ECHO) '0x6076	U+7464		# <cjk>' >> $@
	## 29 characters from JIS X 0208:1997 6.3.4
	$(ECHO) '0x3022	U+555E		# <cjk>' >> $@
	$(ECHO) '0x316B	U+7130		# <cjk>' >> $@
	$(ECHO) '0x322A	U+9DD7		# <cjk>' >> $@
	$(ECHO) '0x337A	U+5699		# <cjk>' >> $@
	$(ECHO) '0x3622	U+4FE0		# <cjk>' >> $@
	$(ECHO) '0x366D	U+8ED0		# <cjk>' >> $@
	$(ECHO) '0x3834	U+9E7C		# <cjk>' >> $@
	$(ECHO) '0x396D	U+9EB4		# <cjk>' >> $@
	$(ECHO) '0x3C48	U+5C62		# <cjk>' >> $@
	$(ECHO) '0x3D2B	U+7E61		# <cjk>' >> $@
	$(ECHO) '0x3E55	U+8523		# <cjk>' >> $@
	$(ECHO) '0x3E5F	U+91AC		# <cjk>' >> $@
	$(ECHO) '0x4066	U+87EC		# <cjk>' >> $@
	$(ECHO) '0x415F	U+6414		# <cjk>' >> $@
	$(ECHO) '0x424D	U+9A52		# <cjk>' >> $@
	$(ECHO) '0x433D	U+7C1E		# <cjk>' >> $@
	$(ECHO) '0x444F	U+6451		# <cjk>' >> $@
	$(ECHO) '0x4536	U+5861		# <cjk>' >> $@
	$(ECHO) '0x453F	U+985A		# <cjk>' >> $@
	$(ECHO) '0x4578	U+79B1		# <cjk>' >> $@
	$(ECHO) '0x4642	U+7006		# <cjk>' >> $@
	$(ECHO) '0x4739	U+56CA		# <cjk>' >> $@
	$(ECHO) '0x482E	U+6F51		# <cjk>' >> $@
	$(ECHO) '0x4830	U+91B1		# <cjk>' >> $@
	$(ECHO) '0x4B4B	U+9830		# <cjk>' >> $@
	$(ECHO) '0x4C4D	U+9EB5		# <cjk>' >> $@
	$(ECHO) '0x4D69	U+840A		# <cjk>' >> $@
	$(ECHO) '0x4F39	U+881F		# <cjk>' >> $@
	$(ECHO) '0x5A39	U+6522		# <cjk>' >> $@
	$(ECHO) '#?o name="gl-jis-1978"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="2"' >> $@
	$(ECHO) '#?o license="Public Domain"' >> $@

.euc-jp-1997-gr-left.tbr.tmp: $(GL_JIS_TBR_FILES) \
  $(TBR_DIR)gl-iso-646-alphanumeric-fw.tbr $(TBR2TBL_PL)
	$(ECHO) '#?PETBL/1.0 SOURCE' > $@.tmp
	$(ECHO) '#?import src="$(TBR_DIR)gl-jisx0208-common.tbr" mode="standard,fullwidth,isoiec646irv,NOT-SIGN,LARGE-CIRCLE,nonhan-1983-add,han-1978-revised,han-1983-revised,han-1983-swapped,han-1983-add,han-1990-revised,han-1990-add"' >> $@.tmp
	$(TBR2TBL) $@.tmp > $@
	$(RM) $@.tmp

euc-jp-1997.tbr:
	$(ECHO) '#?PETBL/1.0 SOURCE' > $@
	$(ECHO) '#?o name="euc-jp-1997"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="3"' >> $@
	$(ECHO) '#?o license="Public Domain"' >> $@
	$(ECHO) '#?import std-cl' >> $@
	$(ECHO) '#?import std-0x20' >> $@
	$(ECHO) '#?import src="$(TBR_DIR)gl-iso-646-alphanumeric.tbr"' >> $@
	$(ECHO) '#?import src="$(TBR_DIR)gl-iso-646-symbol.tbr"' >> $@
	$(ECHO) '#?import std-0x7F' >> $@
	$(ECHO) '0x80	U+0080		# <control>' >> $@
	$(ECHO) '0x81	U+0081		# <control>' >> $@
	$(ECHO) '0x82	U+0082		# <control>' >> $@
	$(ECHO) '0x83	U+0083		# <control>' >> $@
	$(ECHO) '0x84	U+0084		# <control>' >> $@
	$(ECHO) '0x85	U+0085		# <control>' >> $@
	$(ECHO) '0x86	U+0086		# <control>' >> $@
	$(ECHO) '0x87	U+0087		# <control>' >> $@
	$(ECHO) '0x88	U+0088		# <control>' >> $@
	$(ECHO) '0x89	U+0089		# <control>' >> $@
	$(ECHO) '0x8A	U+008A		# <control>' >> $@
	$(ECHO) '0x8B	U+008B		# <control>' >> $@
	$(ECHO) '0x8C	U+008C		# <control>' >> $@
	$(ECHO) '0x8D	U+008D		# <control>' >> $@
	$(ECHO) '0x90	U+0090		# <control>' >> $@
	$(ECHO) '0x91	U+0091		# <control>' >> $@
	$(ECHO) '0x92	U+0092		# <control>' >> $@
	$(ECHO) '0x93	U+0093		# <control>' >> $@
	$(ECHO) '0x94	U+0094		# <control>' >> $@
	$(ECHO) '0x95	U+0095		# <control>' >> $@
	$(ECHO) '0x96	U+0096		# <control>' >> $@
	$(ECHO) '0x97	U+0097		# <control>' >> $@
	$(ECHO) '0x98	U+0098		# <control>' >> $@
	$(ECHO) '0x99	U+0099		# <control>' >> $@
	$(ECHO) '0x9A	U+009A		# <control>' >> $@
	$(ECHO) '0x9B	U+009B		# <control>' >> $@
	$(ECHO) '0x9C	U+009C		# <control>' >> $@
	$(ECHO) '0x9D	U+009D		# <control>' >> $@
	$(ECHO) '0x9E	U+009E		# <control>' >> $@
	$(ECHO) '0x9F	U+009F		# <control>' >> $@
	$(PERL_INPLACE) -e 'print unless /^0x8[EF]/' $@
	$(ECHO) '#?import std-0xA0' >> $@
	$(ECHO) '#?import std-0xFF' >> $@
	$(ECHO) '#?import src=".euc-jp-1997-gr-left.tbr.tmp" right' >> $@
	$(ECHO) '0x8EA1	U+FF61		# HALFWIDTH IDEOGRAPHIC FULL STOP' >> $@
	$(ECHO) '0x8EA2	U+FF62		# HALFWIDTH LEFT CORNER BRACKET' >> $@
	$(ECHO) '0x8EA3	U+FF63		# HALFWIDTH RIGHT CORNER BRACKET' >> $@
	$(ECHO) '0x8EA4	U+FF64		# HALFWIDTH IDEOGRAPHIC COMMA' >> $@
	$(ECHO) '0x8EA5	U+FF65		# HALFWIDTH KATAKANA MIDDLE DOT' >> $@
	$(ECHO) '0x8EA6	U+FF66		# HALFWIDTH KATAKANA LETTER WO' >> $@
	$(ECHO) '0x8EA7	U+FF67		# HALFWIDTH KATAKANA LETTER SMALL A' >> $@
	$(ECHO) '0x8EA8	U+FF68		# HALFWIDTH KATAKANA LETTER SMALL I' >> $@
	$(ECHO) '0x8EA9	U+FF69		# HALFWIDTH KATAKANA LETTER SMALL U' >> $@
	$(ECHO) '0x8EAA	U+FF6A		# HALFWIDTH KATAKANA LETTER SMALL E' >> $@
	$(ECHO) '0x8EAB	U+FF6B		# HALFWIDTH KATAKANA LETTER SMALL O' >> $@
	$(ECHO) '0x8EAC	U+FF6C		# HALFWIDTH KATAKANA LETTER SMALL YA' >> $@
	$(ECHO) '0x8EAD	U+FF6D		# HALFWIDTH KATAKANA LETTER SMALL YU' >> $@
	$(ECHO) '0x8EAE	U+FF6E		# HALFWIDTH KATAKANA LETTER SMALL YO' >> $@
	$(ECHO) '0x8EAF	U+FF6F		# HALFWIDTH KATAKANA LETTER SMALL TU' >> $@
	$(ECHO) '0x8EB0	U+FF70		# HALFWIDTH KATAKANA-HIRAGANA PROLONGED SOUND MARK' >> $@
	$(ECHO) '0x8EB1	U+FF71		# HALFWIDTH KATAKANA LETTER A' >> $@
	$(ECHO) '0x8EB2	U+FF72		# HALFWIDTH KATAKANA LETTER I' >> $@
	$(ECHO) '0x8EB3	U+FF73		# HALFWIDTH KATAKANA LETTER U' >> $@
	$(ECHO) '0x8EB4	U+FF74		# HALFWIDTH KATAKANA LETTER E' >> $@
	$(ECHO) '0x8EB5	U+FF75		# HALFWIDTH KATAKANA LETTER O' >> $@
	$(ECHO) '0x8EB6	U+FF76		# HALFWIDTH KATAKANA LETTER KA' >> $@
	$(ECHO) '0x8EB7	U+FF77		# HALFWIDTH KATAKANA LETTER KI' >> $@
	$(ECHO) '0x8EB8	U+FF78		# HALFWIDTH KATAKANA LETTER KU' >> $@
	$(ECHO) '0x8EB9	U+FF79		# HALFWIDTH KATAKANA LETTER KE' >> $@
	$(ECHO) '0x8EBA	U+FF7A		# HALFWIDTH KATAKANA LETTER KO' >> $@
	$(ECHO) '0x8EBB	U+FF7B		# HALFWIDTH KATAKANA LETTER SA' >> $@
	$(ECHO) '0x8EBC	U+FF7C		# HALFWIDTH KATAKANA LETTER SI' >> $@
	$(ECHO) '0x8EBD	U+FF7D		# HALFWIDTH KATAKANA LETTER SU' >> $@
	$(ECHO) '0x8EBE	U+FF7E		# HALFWIDTH KATAKANA LETTER SE' >> $@
	$(ECHO) '0x8EBF	U+FF7F		# HALFWIDTH KATAKANA LETTER SO' >> $@
	$(ECHO) '0x8EC0	U+FF80		# HALFWIDTH KATAKANA LETTER TA' >> $@
	$(ECHO) '0x8EC1	U+FF81		# HALFWIDTH KATAKANA LETTER TI' >> $@
	$(ECHO) '0x8EC2	U+FF82		# HALFWIDTH KATAKANA LETTER TU' >> $@
	$(ECHO) '0x8EC3	U+FF83		# HALFWIDTH KATAKANA LETTER TE' >> $@
	$(ECHO) '0x8EC4	U+FF84		# HALFWIDTH KATAKANA LETTER TO' >> $@
	$(ECHO) '0x8EC5	U+FF85		# HALFWIDTH KATAKANA LETTER NA' >> $@
	$(ECHO) '0x8EC6	U+FF86		# HALFWIDTH KATAKANA LETTER NI' >> $@
	$(ECHO) '0x8EC7	U+FF87		# HALFWIDTH KATAKANA LETTER NU' >> $@
	$(ECHO) '0x8EC8	U+FF88		# HALFWIDTH KATAKANA LETTER NE' >> $@
	$(ECHO) '0x8EC9	U+FF89		# HALFWIDTH KATAKANA LETTER NO' >> $@
	$(ECHO) '0x8ECA	U+FF8A		# HALFWIDTH KATAKANA LETTER HA' >> $@
	$(ECHO) '0x8ECB	U+FF8B		# HALFWIDTH KATAKANA LETTER HI' >> $@
	$(ECHO) '0x8ECC	U+FF8C		# HALFWIDTH KATAKANA LETTER HU' >> $@
	$(ECHO) '0x8ECD	U+FF8D		# HALFWIDTH KATAKANA LETTER HE' >> $@
	$(ECHO) '0x8ECE	U+FF8E		# HALFWIDTH KATAKANA LETTER HO' >> $@
	$(ECHO) '0x8ECF	U+FF8F		# HALFWIDTH KATAKANA LETTER MA' >> $@
	$(ECHO) '0x8ED0	U+FF90		# HALFWIDTH KATAKANA LETTER MI' >> $@
	$(ECHO) '0x8ED1	U+FF91		# HALFWIDTH KATAKANA LETTER MU' >> $@
	$(ECHO) '0x8ED2	U+FF92		# HALFWIDTH KATAKANA LETTER ME' >> $@
	$(ECHO) '0x8ED3	U+FF93		# HALFWIDTH KATAKANA LETTER MO' >> $@
	$(ECHO) '0x8ED4	U+FF94		# HALFWIDTH KATAKANA LETTER YA' >> $@
	$(ECHO) '0x8ED5	U+FF95		# HALFWIDTH KATAKANA LETTER YU' >> $@
	$(ECHO) '0x8ED6	U+FF96		# HALFWIDTH KATAKANA LETTER YO' >> $@
	$(ECHO) '0x8ED7	U+FF97		# HALFWIDTH KATAKANA LETTER RA' >> $@
	$(ECHO) '0x8ED8	U+FF98		# HALFWIDTH KATAKANA LETTER RI' >> $@
	$(ECHO) '0x8ED9	U+FF99		# HALFWIDTH KATAKANA LETTER RU' >> $@
	$(ECHO) '0x8EDA	U+FF9A		# HALFWIDTH KATAKANA LETTER RE' >> $@
	$(ECHO) '0x8EDB	U+FF9B		# HALFWIDTH KATAKANA LETTER RO' >> $@
	$(ECHO) '0x8EDC	U+FF9C		# HALFWIDTH KATAKANA LETTER WA' >> $@
	$(ECHO) '0x8EDD	U+FF9D		# HALFWIDTH KATAKANA LETTER N' >> $@
	$(ECHO) '0x8EDE	U+FF9E		# HALFWIDTH KATAKANA VOICED SOUND MARK' >> $@
	$(ECHO) '0x8EDF	U+FF9F		# HALFWIDTH KATAKANA SEMI-VOICED SOUND MARK' >> $@
	$(ECHO) '#?import src="$(TBR_DIR)gl-jisx0212-common.tbr" mode="fullwidth,isoiec646irv,BROKEN-BAR,han" offset="0x8F8080"' >> $@

shift-jis-1997.tbr:
	cp $(CPTBR_DIR)cp932-ms.tbr $@
	$(PERL_INPLACE) -e 'print unless /^0x(?:5C|7E|8(?:[07]|1(?:5[CF]|6[01]|7C|9[12]|CA))|A0|F)|<-|->/' $@
	$(ECHO) '0x5C	U+00A5		# YEN SIGN' >> $@
	$(ECHO) '0x7E	U+203E		# OVERLINE' >> $@
	$(ECHO) '0x815C	U+2014		# EM DASH' >> $@
	$(ECHO) '0x815F	U+005C		# REVERSE SOLIDUS' >> $@
	$(ECHO) '0x8160	U+301C		# WAVE DASH' >> $@
	$(ECHO) '0x8161	U+2016		# DOUBLE VERTICAL LINE' >> $@
	$(ECHO) '0x817C	U+2212		# MINUS SIGN' >> $@
	$(ECHO) '0x8191	U+00A2		# CENT SIGN' >> $@
	$(ECHO) '0x8192	U+00A3		# POUND SIGN' >> $@
	$(ECHO) '0x81CA	U+00AC		# NOT SIGN' >> $@
	$(ECHO) '#?o name="shift-jis-1997"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="2"' >> $@
	$(ECHO) '#?o license="Public Domain"' >> $@

euc-jp-1997.tbl: %.tbl: %.tbr \
  $(TBR_DIR)gl-iso-646-alphanumeric.tbr $(TBR_DIR)gl-iso-646-symbol.tbr \
  $(TBR_DIR)gl-iso-646-alphanumeric-fw.tbr $(TBR_DIR)gl-jisx0212-common.tbr \
  .euc-jp-1997-gr-left.tbr.tmp $(TBR2TBL_PL)
	$(TBR2TBL) $< > $@

euc-jp-1997-open-nec.tbl:
	cp $(EUCTBL_DIR)euc-jp-1997-open-nec.tbl $@.tmp
	$(ECHO) '#?PETBL/1.0 SOURCE' > $@
	$(ECHO) '#?o name="euc-jp-1997-open-nec"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="3"' >> $@
	$(CAT) $@.tmp >> $@
	$(RM) $@.tmp

euc-jp-sw.tbl:
	cp $(EUCTBL_DIR)euc-jp-sw.tbl $@.tmp
	$(ECHO) '#?PETBL/1.0 SOURCE' > $@
	$(ECHO) '#?o name="euc-jp-sw"' >> $@
	$(ECHO) '#?o <-ucs-substition="0x30FB"' >> $@
	$(ECHO) '#?o ucm:mb_cur_max="3"' >> $@
	$(CAT) $@.tmp >> $@
	$(RM) $@.tmp

shift-jis-1997.tbl: %.tbl: %.tbr $(TBR2TBL_PL)
	$(TBR2TBL) $< > $@

%.tbl: %.tbr $(TBR2TBL_PL)
	$(TBR2TBL) $< > $@

%.ucm: %.tbl $(TBL2UCM_PL)
	$(TBL2UCM) $< > $@

GLJIS1978 GLJIS1983 GLJIS1997: GLJIS%: gl-jis-%.ucm
	$(MKDIR) -p $@
	$(CP) $< $@/$<
	$(CD) $@ && $(ENC2XS) -M $@ $<
	$(CD) $@ && $(PERL_) ./Makefile.PL
	$(CD) $@ && $(MAKE) manifest dist
GLJIS1997Swapped: gl-jis-1997-swapped.ucm
	$(MKDIR) -p $@
	$(CP) $< $@/$<
	$(CD) $@ && $(ENC2XS) -M $@ $<
	$(CD) $@ && $(PERL_) ./Makefile.PL
	$(CD) $@ && $(MAKE) manifest dist
EUCJP1997: euc-jp-1997.ucm
	$(MKDIR) -p $@
	$(CP) $< $@/$<
	$(CD) $@ && $(ENC2XS) -M $@ $<
	$(CD) $@ && $(PERL_) -i -p -e 's/"0\.01"/"0.02"/' $@.pm
	$(CD) $@ && $(PERL_) ./Makefile.PL
	$(CD) $@ && $(MAKE) manifest dist
EUCJP1997OPENNEC: euc-jp-1997-open-nec.ucm
	$(MKDIR) -p $@
	$(CP) $< $@/$<
	$(CD) $@ && $(ENC2XS) -M $@ $<
	$(CD) $@ && $(PERL_) ./Makefile.PL
	$(CD) $@ && $(MAKE) manifest dist
EUCJPSW: euc-jp-sw.ucm
	$(MKDIR) -p $@
	$(CP) $< $@/$<
	$(CD) $@ && $(ENC2XS) -M $@ $<
	$(CD) $@ && $(PERL_) ./Makefile.PL
	$(CD) $@ && $(MAKE) manifest dist
ShiftJIS1997: shift-jis-1997.ucm
	$(MKDIR) -p $@
	$(CP) $< $@/$<
	$(CD) $@ && $(ENC2XS) -M $@ $<
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
