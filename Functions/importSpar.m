function S=importSpar(Path,headerlinesIn)
%Path="gapphaseshifttestgrapheneind10Doubleh1_1.s2p"
%headerlinesIn=11;
A=importdata(Path,' ',headerlinesIn);
S=A.data;
end