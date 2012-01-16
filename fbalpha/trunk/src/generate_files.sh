#!/bin/bash

#generate gamelist.txt and generated/driverlist.h
echo ""
echo "generate_driverlist.sh: Generate all files from scripts directory"
echo ""
echo "1) gamelist.pl"
perl depend/scripts/gamelist.pl -o generated/driverlist.h -l gamelist.txt \
burn/drivers/capcom \
burn/drivers/cave \
burn/drivers/cps3 \
burn/drivers/dataeast \
burn/drivers/galaxian \
burn/drivers/irem \
burn/drivers/konami \
burn/drivers/megadrive \
burn/drivers/misc_post90s \
burn/drivers/misc_pre90s \
burn/drivers/neogeo \
burn/drivers/pgm \
burn/drivers/psikyo \
burn/drivers/sega \
burn/drivers/snes \
burn/drivers/taito \
burn/drivers/toaplan

#generate generated/neo_sprite_func.h and generated/neo_sprite_func_table.h
echo ""
echo "2) neo_sprite_func.pl"
perl depend/scripts/neo_sprite_func.pl -o generated/neo_sprite_func.h

#generate generated/psikyo_tile_func.h and generated/psikyo_tile_func_table.h
echo ""
echo "3) psikyo_tile_func.pl"
perl depend/scripts/psikyo_tile_func.pl -o generated/psikyo_tile_func.h

#generate generated/cave_sprite_func.h and generated/cave_sprite_func_table.h
echo ""
echo "4) cave_sprite_func.pl"
perl depend/scripts/cave_sprite_func.pl -o generated/cave_sprite_func.h

#generate generated/cave_tile_func.h and generated/cave_tile_func_table.h
echo ""
echo "5) cave_tile_func.pl"
perl depend/scripts/cave_tile_func.pl -o generated/cave_tile_func.h

#generate generated/toa_gp9001_func.h and generated/toa_gp9001_func_table.h
echo ""
echo "6) toa_gp9001_func.pl"
perl depend/scripts/toa_gp9001_func.pl -o generated/toa_gp9001_func.h

echo ""
echo "7) pgm_sprite_create.cpp"
g++ -o pgm_sprite_create burn/drivers/pgm/pgm_sprite_create.cpp
./pgm_sprite_create > burn/drivers/pgm/pgm_sprite.h

#compile m68kmakeecho 
echo ""
echo "8) compile m68kmake"
gcc -o m68kmake cpu/m68k/m68kmake.c

#create m68kops.h with m68kmake
echo ""
echo "9) Create m68kops.h with m68kmake"
./m68kmake cpu/m68k/ cpu/m68k/m68k_in.c

#compile ctv_make
echo ""
echo "10) compile ctvmake"
g++ -o  ctvmake burn/drivers/capcom/ctv_make.cpp

#create ctv.h
echo ""
echo "11) Create ctv.h with ctvmake"
./ctvmake > generated/ctv.h
