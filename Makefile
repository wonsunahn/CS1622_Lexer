TARGETS = lexer
TESTS = $(wildcard tests/*.mjava)
OUTPUTS := $(foreach test,$(TESTS),outputs/$(test:tests/%.mjava=%).out)
DIFFS_DEFAULT := $(foreach test,$(TESTS),diffs_default/$(test:tests/%.mjava=%).diff)
DIFFS_SIDE_BY_SIDE := $(foreach test,$(TESTS),diffs_side_by_side/$(test:tests/%.mjava=%).diff)

CC = gcc
C++ = g++
FLEX = flex

all: build test
build: $(TARGETS)
test: $(OUTPUTS) $(DIFFS_DEFAULT) $(DIFFS_SIDE_BY_SIDE)

lexer: driver.o token.o table.o lex.yy.o 
	$(CC) -g -o lexer driver.o token.o table.o lex.yy.o -ll -lstdc++
driver.o: driver.c token.h
	$(CC) -g -c driver.c
token.o: token.c token.h
	$(CC) -g -c token.c
table.o  : table.cpp
	$(C++) -g -c table.cpp
lex.yy.o : lex.yy.c 
	$(CC) -g -c lex.yy.c 
lex.yy.c: lex.l token.h
	$(FLEX) lex.l

define test_rules
outputs/$(1:tests/%.mjava=%).out: lexer $(1)
	@echo "cat $(1) | ./lexer > $$@"
	-@cat $(1) | ./lexer > $$@
endef
$(foreach test,$(TESTS),$(eval $(call test_rules,$(test))))

define diff_rules
diffs_default/$(1:tests/%.mjava=%).diff: outputs/$(1:tests/%.mjava=%).out
	@echo "diff -dy -W 170 $$< outputs_solution/$(1:tests/%.mjava=%).out > $$@"
	-@diff -d $$< outputs_solution/$(1:tests/%.mjava=%).out > $$@
diffs_side_by_side/$(1:tests/%.mjava=%).diff: outputs/$(1:tests/%.mjava=%).out
	@echo "diff -dy -W 170 $$< outputs_solution/$(1:tests/%.mjava=%).out > $$@"
	-@diff -dy -W 120 $$< outputs_solution/$(1:tests/%.mjava=%).out > $$@
endef
$(foreach test,$(TESTS),$(eval $(call diff_rules,$(test))))

clean:
	rm -f *.o lex.yy.c lexer outputs/*.out diffs_default/*.diff diffs_side_by_side/*.diff