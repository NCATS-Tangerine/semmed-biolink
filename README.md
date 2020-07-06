# semmed-biolink

This project provides a systematic protocol of (bash shell and Python) scripts to load the the [Semantic Medline Database ("semmeddb")](https://skr3.nlm.nih.gov/SemMedDB/) into a [Biolink Model](https://github.com/biolink/biolink-model) compliant Neo4j database.  

## Processing Options

These operations are best attempted on a *nix system (Linux, OSX) given the dependency of various steps on *nix specific (bash) and OS operations.

Note that the original "classical" project formula involved the downloading of the SemMedDb source dataset and associated metadata, then the post-processing of the data using Jupyter Notebooks. 

A "new" procedure relying more heavily on the [NCATS KGX project software]() could be under development and may become the standard procedure in the (near) future.

## Prerequisites

Some of the ontology and identifier  cross-reference resolution operations (Jupyter Notebook '05-xrefs') require external software to be pre-installed:

1. The module `wikidataintegrator`, which should be installed locally, i.e.
  
```
pip install wikidataintegrator
```

2. The [Robot SPARQL query CLI tool](http://robot.obolibrary.org/)

3. The PyQuery modules:

``` 
pip install pyquery
```

## The Common (Meta-)Data Downloading Step

For both protocols, the following data and meta-data downloading steps are required before either post-processing operations are attempted.

First,  for convenience, run the shell `source` command on the `setup_environment.sh` script, to set up environment variables for the work. See this script for what variables are set (and may be overridden).

Next, download the (meta-)data.  Unfortunately, the original protocol used a `bash` script to download the (meta-)data but given NLM (UTS) authentication is required to access some of these files, then the original `dataload_convert.sh` script won't likely work and has been tagged as deprecated. Rather, the following  steps should be used:

1. Log into NLM UTS and download the following target into your chosen working directory, URLs as defined by the specified environment variables (in CAPS below)  which were set by the `setup_environment.sh` script:

    1. SEMMEDDB_PREDICATION_DOWNLOAD
    1. UMLS_DOWNLOAD

2. Download the following drug identifier data from  [UNII_Data.zip](https://fdasis.nlm.nih.gov/srs/download/srs/UNII_Data.zip)

3. Download the following [OBO ontology file for Uberon](http://purl.obolibrary.org/obo/uberon.owl). After downloading these files, a CSV file must be generated using the 'robot' query tool, as follows (note that the obo_query.sparql file is in the root directory of this project)

```
robot query --input uberon.owl --query obo_query.sparql uberon.csv
```
    
4. Similarly, download the following [OBO ontology file for DOID](http://purl.obolibrary.org/obo/doid.owl). After downloading these files, a CSV file must be generated using the 'robot' query tool, as follows:

```
robot query --input doid.owl --query obo_query.sparql doid.csv
```
    
5. Run the `predications_to_csv.sh` script (which converts the SEMMEDDB_PREDICATION_ARCHIVE file to the SEMMEDDB_PREDICATION_CSV file).

6. Manually unzip the UMLS_ARCHIVE, extracting the contained files into one folder (e.g. `2020AA-full`). Also unzip the embedded `mmsys.zip` archive. This archive contains the MetamorphoSys - The UMLS Installation and Customization Program which must now be used to generate the required Metathesaurus - Rich Release Format (RRF) files (see list below). Running the startup script for the 'mmsys' application (specific script for your chosen platform) brings up the Metamorphosys application dialog dialog box. Select "Install UMLS" and you only need to select the "Metathesaurus" option. When prompted for a configuration, selection "New Configuration" which will ask you to select the level of vocabulary extraction. Choose "Level 0" (for minimal IP complexities). Modify any additional input and output details in the full dialog if necessary (input is NLM, output is RRF), then initiate subset generation (Note: the way to initiate this seems to subtly vary between operating systems, so read the [Metamorphosys documentation](https://www.nlm.nih.gov/research/umls/implementation_resources/metamorphosys/help.html) for clarification). After the vocabulary subsets are generated, apply the following (*nix OS) operations on the indicated "Rich Release Format" ("RRF") files that were generated by the above operation, to prepare them for use in the SemMedDb processing protocols:

    1. gzip -c MRCONSO.RRF  > MRCONSO.RRF.gz
    2. gzip -c MRSAT.RRF > MRSAT.RRF.gz 
    3. cat MRCONSO.RRF | grep -F "|ENG|" | gzip > MRCONSO_ENG.RRF.gz
    4. gzip -c MRSTY.RRF > MRSTY.RRF.gz 

## New KGX Data Processing Procedure

T.B.A.

## "Classical" Data Processing Procedure

Run the following Jupiter Notebooks (ipynb's) in order

01-initial_data_clean.ipynb
- Expand predicates with OR operations into individual predicates
- Convert CUIs that are Entrez ids into CUIs
- Change neg props to the same prop with a negative flag
- Make a separate nodes table

02-normalize_node_types_to_biolink.ipynb
- For each node, get the UMLS semantic type for each umls cui
- Map UMLS semantic types to Biolink node types (blm_to_umls_nodes.json)
- Nodes with no matching type are removed

03-filter_nodes_edges.ipynb
- Remove edges with nodes with no umls type or label
- Remove the following predicates: ['compared_with', 'higher_than', 'lower_than', 'different_from', 'different_than', 
'same_as','OCCURS_IN', 'PROCESS_OF', 'DIAGNOSES', 'METHOD_OF', 'USES','AUGMENTS', 'ADMINISTERED_TO', 'COMPLICATES']

04-filter_biolink
 - Filter specific domain and ranges for: CAUSES, LOCATION_OF, TREATS, PREDISPOSES, PREVENTS
 - rename 'converts_to' edge to 'derives_into'
 - rename 'isa' edge to 'subclass of'
 - rename 'disrupts' edge to 'affects'
 - rename 'associated_with' edge to 'related_to'
 - rename 'STIMULATES' edge to 'positively_regulates'
 - rename 'INHIBITS' edge to 'negatively_regulates'
 - associated_with/related_to edges with domain: gene, range: disease; rename to gene_associated_with_condition

05-xrefs

Get xrefs from a variety of sources
- Drugs: 
UMLS has mesh xrefs. From mesh, we can get UNII and CAS. From UNII_FDA, we can get inchikeys 
(lookup using cas or unii). From chembl, we can get chembl IDs from the inchikeys
So: UMLS -> mesh -> unii/cas -> inchikey -> chembl
insane, I know.
- Anatomy: uberon has umls xrefs
- disease: DO has umls, umls has NCI, ICD10PCS, SNOMEDCT_US, ICD10CM, OMIM
- proteins: umls has uniprot xrefs
- biological_process_or_activity/activity_and_behavior: umls has GO
- gene: umls has HGNC and OMIM

06a-neo4j-classical-load
- reformat for neo4j import (old method, not using KGX)

006-kgx-load
- reformat the SemMedDb datasets for KGX import

