# The DATA and UMLS directories should be parameterized with an external environment variable but are hardcoded for now
DATA = 'data/'

# The SemMedDb version will change between updates and should be externally set somehow?
SEMMEDDB_PREDICATION_CSV = DATA+"semmedVER42_2020_R_PREDICATION.csv"

# The UMLS release will likely change between updates and should be externally set somehow?
UMLS = DATA+"2020AA_Active/"
MRSAT_ARCHIVE = UMLS+"MRSAT.RRF.gz"
MRCONSO_ENG_ARCHIVE = UMLS+"MRCONSO_ENG.RRF.gz"
MRSTY_ARCHIVE = UMLS+"MRSTY.RRF.gz"

# The MetaMap semantic encodings may periodically change thus should probably be externally set somehow?
SEMGROUPS = "https://metamap.nlm.nih.gov/Docs/SemGroups_2013.txt"
SEMTYPES = "https://metamap.nlm.nih.gov/Docs/SemanticTypes_2013AA.txt"

# Pipeline of data files, don't really need to change between updates
EDGES1_TSV = DATA + "edges1.tsv"
EDGES2_TSV = DATA + "edges2.tsv"
EDGES3_TSV = DATA + "edges3.tsv"
EDGES4_TSV = DATA + "edges4.tsv"

NODES1_TSV = DATA + "nodes1.tsv"
NODES_BLM_TSV = DATA + "nodes_blm.tsv"

EDGES_FILTERED_TSV = DATA + "edges_filtered.tsv"
NODES_FILTERED_TSV = DATA + "nodes_filtered.tsv"

EDGES_BIOLINK_TSV = DATA + "edges_biolink.tsv"
NODES_BIOLINK_TSV = DATA + "nodes_biolink.tsv"

UNII_RECORDS = DATA+"UNII_Records_23May2020.txt"
XREFS_SHELVE = DATA+"xrefs.shelve"
UBERON_CSV = DATA+"uberon.csv"
DOID_CSV = DATA+"doid.csv"

MESH_XREFS_TSV = DATA+"mesh_xrefs.tsv"

NODES_XREF_TSV = DATA + "nodes_xref.tsv"

NODES_KGX_TSV = DATA+"nodes_kgx.tsv"
EDGES_KGX_TSV = DATA+"edges_kgx.tsv"
