all: auto/directories.svg

clean:
	rm -rf auto/*

auto/directories.svg: directories.dot
	dot $< -Tsvg | grep -v 'polygon fill="white"' > $@

DIRS=Client Core Event Examples Protocol RPC Server Storage Tree
DIR_IMAGES = $(foreach d,$(DIRS),auto/directories-$(d).svg)

all: $(DIR_IMAGES)

$(DIR_IMAGES): auto/directories-%.svg: directories.dot
	( \
	  head -n -1 $<; \
	  echo '$* [width=2, height=1.5, fillcolor="#2b83ba", fontcolor="white", fontname="Mono Bold", fontsize=26];'; \
	  echo '}'; \
	) \
	| dot -Tsvg \
	| grep -v 'polygon fill="white"' \
	> $@

# The following target is useful for debugging Makefiles; it
# prints the value of a make variable.
print-%:
	@echo $* = $($*)
