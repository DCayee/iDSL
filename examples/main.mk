CXX := g++
CXXFLAGS := -Wall
LFLAGS := -L. -fpic -g

OBJECTS := $(patsubst %.cpp,%.o,$(SRC))
DEPENDENCIES := $(patsubst %.cpp,%.d,$(SRC))

default: debug

debug: CXXFLAGS += -DDEBUG -O0 -g
debug: $(EXECUTABLE)

release: CXXFLAGS += -DNDEBUG -O3 -g -ftree-vectorize
release: $(EXECUTABLE)

$(EXECUTABLE) : $(OBJECTS)
	$(CXX) $(LFLAGS) -o $@ $^ $(LIBS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -rf $(EXECUTABLE) $(OBJECTS) $(DEPENDENCIES)

# dependency rules
%.d: %.cpp
	@$(CXX) $(CXXFLAGS) -MM -MT '$@ $(@:.d=.o)' $< -o $@

-include $(DEPENDENCIES)