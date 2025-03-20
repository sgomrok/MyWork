#!/usr/bin/env python3

import os
import subprocess


def find_template_pdb(max_levels=3):
    current_dir = os.getcwd()
    for _ in range(max_levels + 1):  # +1 to check the current directory as well
        candidate = os.path.join(current_dir, "template.pdb")
        if os.path.isfile(candidate):
            return candidate
        # Move one directory up
        parent_dir = os.path.dirname(current_dir)
        if parent_dir == current_dir:
            break
        current_dir = parent_dir
    raise FileNotFoundError("template.pdb not found within {} levels above.".format(max_levels))



directories = [
    'irc1',
    '.',
    'irc2'
]

current_directory_path = os.getcwd()            
current_directory_name = os.path.basename(current_directory_path)


for d in directories:
    # Change directory temporarily
    prev_dir = os.getcwd()
    os.chdir(d)
    template_path = find_template_pdb(max_levels=3)
    if d == '.':
        print(f'Now in {current_directory_name} directory')
    else:
        print(f'Now in {d} directory')
    # get pdb of the optimized structure
    subprocess.run([
        'python3', 
        os.path.expanduser('~/git/rinrus2022/bin/gopt_to_pdb.py'),
        '-p', template_path,
        '-o', '1.out',
        '-f', '-1'
    ])
    
    subprocess.run([
        'python3', 
        os.path.expanduser('~/git/chenglab/scripts/extractE_from_gfreq.py'),
        '1.out', '1'
    ])
    # Go back to the previous directory
    os.chdir(prev_dir)
    print(*['-' for i in range(50)])

