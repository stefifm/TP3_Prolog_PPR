%Hechos del TP3

%Rasonmware
ransomware(1,'Grandcrab',78.5,fecha(10,1,2020),[enero,febrero,marzo,abril]).
ransomware(2,'Babuk',7.61,fecha(5,7,2020),[julio,agosto]).
ransomware(3,'Cerber',3.11,fecha(20,1,2020),[enero,febrero,diciembre]).
ransomware(4,'Matsnu',2.63,fecha(3,4,2020),[abril,octubre]).
ransomware(5,'Wannacry',2.41,fecha(29,6,2020),[junio,septiembre]).
ransomware(6,'Congur',1.52,fecha(5,7,2020),[julio]).
ransomware(7,'Locky',1.29,fecha(12,5,2020),[mayo,diciembre]).
ransomware(8,'Teslacrypt',1.12,fecha(4,11,2020),[noviembre,diciembre]).
ransomware(9,'Rkor',1.11,fecha(10,3,2020),[marzo,mayo]).
ransomware(10,'Reveton',0.70,fecha(29,8,2020),[agosto]).

%Tipos de archivos
archivo(1,'Pe').
archivo(2,'Android').
archivo(3,'Dll').
archivo(4,'Gzip').
archivo(5,'Javascript').

%Troyanos
troyano('Emotet',true,1,[2,3,4]).
troyano('Ezbot',false,3,[6,1,10,2]).
troyano('Edridex',false,5,[9,5,3]).
troyano('Egozi',true,4,[7,10,4]).
troyano('Edanabot',true,2,[8,1,5]).

%Resolucion de cada punto del TP3

%p1/3 Retorne si existe o no un ransomware que haya aparecido en un mes/año pasado como argumento 
%y que se haya visto también en el mes de diciembre. (10pts)
%Ejemplo de ejecucion: p1(R,1,2020). Resultado: 'Cerber'. p1(R,6,2020). Resultado: false
p1(R,M,A) :- ransomware(_,R,_,fecha(_,M,A),Lis), member(diciembre, Lis).

%p2/3 Dado un nombre de ransomware, muestre el nombre del malware que lo distribuye 
%y el tipo de archivo que se usa para distribuirlo.
%Ejemplo de ejecucion: 
%p2('Cerber',Malware,Archivo).
%Resultado:
%Malware = 'Emotet',
%Archivo = 'Pe' ;
%Malware = 'Edridex',
%Archivo = 'Javascript'.
p2(R,Malware,Archivo) :- ransomware(N,R,_,_,_), archivo(Id,Archivo) ,troyano(Malware,_,Id,Lista), member(N, Lista).


%p3/1 Listar todos los ransomware que se vieron por primera vez entre Enero y Marzo del 2020.
%Ejemplo de ejecucion:  p3(L). Resultado: L = ['Grandcrab', 'Cerber', 'Rkor'].
p3(L) :- findall(R, ( ransomware(_,R,_,fecha(_,M,_),_),M>=1,M=<3), L).

%p4/1 Listar sin repetir todos los ransomware que tuvieron campañas en enero y diciembre.
%Ejemplo de ejecucion: p4(L) .Resultado: L = ['Cerber'].
p4(L) :- findall(R,( ransomware(_,R,_,_,Lis), member(enero, Lis),member(diciembre, Lis)),Lista), sort(Lista, L).

%p5/1 Retorne la cantidad de ransomware que puede ser distribuido por un Malware detectable por firma.
%Ejemplo de ejecucion: p5(C). Resultado: C = 8.
p5(C) :- findall(N, (troyano(_,true,_,Lis), member(N, Lis)),L), sort(L, NL), length(NL, C).

%p6/2 Dada una lista de tipos de archivos, retornar una lista de nombres de ransomware (sin repetir) 
%que pueden ser distribuidos por esos tipos de archivos. NO debe usar findall.
%ejemplo de ejecucion:
%p6(['Pe','Android','Dll','Gzip','Javascript'],L).
%Resultado: L = ['Babuk', 'Cerber', 'Congur', 'Grandcrab', 'Locky', 'Matsnu', 'Reveton', 'Rkor', 'Teslacrypt'|...].

add(B,L) :- archivo(Id,_),ransomware(N,H,_,_,_),troyano(_,_,Id,Lis), member(N, Lis), not(member(H,B)),add([H|B],L),!.
add(B,L) :- L = B,!.

p6([],[]).
p6([X|Xs],L) :- archivo(_,X) ,add([],NL),sort(NL, L), p6(Xs,_).




