# run the relaxation after reaction
# $1 = i-1
# $2 = threads
# $3 = time
#source /usr/local/gromacs/bin/GMXRC
cp ../product.itp ../itp/loop$(($1+1)).itp
if [ -f "../md/md$(($1+1)).gro" ]; then
    rm ../md/md$(($1+1)).gro
fi
#gmx grompp -f ../data/martini_em.mdp -c ../md/temp.gro -p ../topol.top -o ../min/min$(($1+1)).tpr -maxwarn 1
#gmx mdrun -v -deffnm ../min/min$(($1+1)) -nt $2
#gmx grompp -f ../data/martini_eqxl.mdp -c ../min/min$(($1+1)).gro -p ../topol.top -o ../md/md$(($1+1)).tpr
#gmx mdrun -v -deffnm ../md/md$(($1+1)) -nt $2
if [ -f "../md/md$(($1+1)).gro" ]; then
    echo 0 | gmx trjconv -f ../md/md$(($1+1)).xtc -s ../md/md$(($1+1)).tpr -o ../md/md$(($1+1)).gro -b $3 -e $3
else
    gmx grompp -f ../data/martini_em.mdp -c ../md/temp.gro -p ../topol.top -o ../min/min$(($1+1)).tpr -maxwarn 1
    gmx mdrun -v -deffnm ../min/min$(($1+1)) -nt $2
    gmx grompp -f ../data/martini_eqxl.mdp -c ../min/min$(($1+1)).gro -p ../topol.top -o ../md/md$(($1+1)).tpr
    gmx mdrun -v -deffnm ../md/md$(($1+1)) -nt $2
    echo 0 | gmx trjconv -f ../md/md$(($1+1)).xtc -s ../md/md$(($1+1)).tpr -o ../md/md$(($1+1)).gro -b $3 -e $3
fi
rm ../md/#md$(($1+1)).gro.1#
rm ../min/#min$(($1+1)).gro.1#
rm ../md/temp.gro
rm *.pdb > /dev/null 2>&1
