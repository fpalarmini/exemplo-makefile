# # teste com makefile simples

# # make all vai gerar o binário teste_makefile
# all: teste_makefile

# # o requisito para gerar o binário são os objetos
# teste_makefile: main.o classSample.o
# 	g++ -o teste_makefile main.o classSample.o

# # receita para gerar o objeto main.o
# main.o: main.cpp classSample.h
# 	g++ -o main.o main.cpp -c -Wall -pedantic -std=c++11

# # receita para gerar o objeto classSample.o
# # depois de gerar os dois objetos, volta para a receita de teste_makefile
# classSample.o: classSample.cpp classSample.h
# 	g++ -o classSample.o classSample.cpp -c -Wall -pedantic -std=c++11

# clean:
# 	rm -rf *.o teste_makefile



# teste com makefile mais completo

# nome do projeto sera nosso binario final
PROJETO=teste_makefile

# wildcard pega todos os arquivos *.cpp
CPP_SOURCE=$(wildcard ./source/*.cpp)

# wildcard pega todos os arquivos *.h
HEADER_SOURCE=$(wildcard ./source/*.h)

# copia todos os .cpp de ./source para ./objects trocando .cpp por .o
OBJ=$(subst .cpp,.o,$(subst source,objects,$(CPP_SOURCE)))

# compilador
CXX=g++

# flags do compilador
CXX_FLAGS=-c         \
         -W         \
         -Wall      \
         -ansi      \
         -pedantic

# alias para rm -rf
RM=rm -rf


all: objFolder $(PROJETO)

# $@ - nome do target
# $^ - lista todos os pre requisitos 
$(PROJETO): $(OBJ)
	@ echo 'Building binary using G++ linker: $@'
	$(CXX) $^ -o $@
	@ echo 'finished: $@'
	@ echo ' '

# % representa o nome do target
# $< pega o nome do primeiro requisito
./objects/%.o: ./source/%.cpp ./source/%.h
	@ echo 'Building target using gcc: $<'
	$(CXX) $< $(CXX_FLAGS) -o $@
	@ echo ' '

./objects/main.o: ./source/main.cpp $(HEADER_SOURCE)
	@ echo 'Building target using gcc: $<'
	$(CXX) $< $(CXX_FLAGS) -o $@
	@echo ' '

objFolder:
	@ mkdir -p objects

clean:
	@ $(RM) ./objects/*.o $(PROJETO) *~
	@ rmdir objects

# necessario para garantir que nao de conflito caso haja arquivos all.cpp ou clean.cpp no codigo
.PHONY: all clean


