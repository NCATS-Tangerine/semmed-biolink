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
EDGES1_CSV = DATA+"edges1.csv"
EDGES2_CSV = DATA+"edges2.csv"
EDGES3_CSV = DATA+"edges3.csv"
EDGES4_CSV = DATA+"edges4.csv"

NODES1_CSV = DATA+"nodes1.csv"
NODES_BLM_CSV = DATA+"nodes_blm.csv"

EDGES_FILTERED_CSV = DATA+"edges_filtered.csv"
NODES_FILTERED_CSV = DATA+"nodes_filtered.csv"

EDGES_BIOLINK_CSV = DATA+"edges_biolink.csv"
NODES_BIOLINK_CSV = DATA+"nodes_biolink.csv"

UNII_RECORDS = DATA+"UNII_Records_23May2020.txt"
XREFS_SHELVE = DATA+"xrefs.shelve"
UBERON_CSV = DATA+"uberon.csv"
DOID_CSV = DATA+"doid.csv"
MESH_XREFS_CSV = DATA+"mesh_xrefs.csv"
NODES_XREF_CSV = DATA+"nodes_xref.csv"

NODES_KGX_CSV = DATA+"nodes_kgx.csv"
EDGES_KGX_CSV = DATA+"edges_kgx.csv"
