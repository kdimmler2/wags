from pathlib import Path

infile = open('/users/7/dimml002/Sample_Organization/Spring2024/MasterRER_Jan2024.tsv', 'rt')
outfile = open('one_wag.tsv', 'wt')

print('horseid,breed,gender,fastq_id', file=outfile)

# Define the directory
fastq_dir = Path("FASTQs")

# Loop through files and extract sample names
sample_names = []
for file in fastq_dir.glob("*.fastq.gz"):
    if file.is_file():
        # Extract the filename and split at the first underscore
        sample_name = file.stem.split('_')[0]
        if sample_name not in sample_names:
            sample_names.append(sample_name)

samples = {}

line = infile.readline()

for line in infile:
    line = line.rstrip()
    split = line.split('\t')
    if split[0] != 'NA':
        if split[0] in sample_names and split[6] != 'QH':
            if split[4] == 'gelding' or split[4] == 'stallion' or split[4] == 'Ridgling' or split[4] == 'colt' or split[4] == 'male':
                sex = 'M'
            elif split[4] == 'mare':
                sex = 'F'
            elif split[4] == 'NA' or split[4] == 'unknown':
                sex = 'NA'
            else:
                print(split[4])
            print(split[0], split[6], sex, split[0], sep=',', file=outfile)
    else: 
        if split[1] in sample_names and split[6] != 'QH':
            if split[4] == 'gelding' or split[4] == 'stallion' or split[4] == 'Ridgling' or split[4] == 'colt' or split[4] == 'male':
                sex = 'M'
            elif split[4] == 'mare':
                sex = 'F'
            elif split[4] == 'NA' or split[4] == 'unknown':
                sex = 'NA'
            else:
                print(split[4])
            print(split[1], split[6], sex, split[1], sep=',', file=outfile)



