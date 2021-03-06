# semmed-biolink

This project provides a systematic protocol of (bash shell and Python) scripts to load the the [Semantic Medline Database ("semmeddb")](https://ii.nlm.nih.gov/SemRep_SemMedDB_SKR/SemMedDB/SemMedDB_download.shtml) into a [Biolink Model](https://github.com/biolink/biolink-model) compliant Neo4j database.  

The data processing operations documented in this project are best attempted on a *nix system (Linux, OSX) given the dependency of various steps on *nix specific OS scripts and operations.

The Semantic Medline Database release to be processed, along with UMLS and other (meta-)data release choices, is now parameterized by the values of environment variables set in a `.env` file in the root directory (see below), for which a `template.env` sample is provided (based on (meta-)data available in late June 2020).  Thus, the project may be rerun largely intact on future data releases (unless the underlying data models and metadata formats change - everyone's mileage may vary in the future)

## 3rd Party Software Dependencies

Some of the ontology and identifier  cross-reference resolution operations (Jupyter Notebook '05-xrefs') require external software to be pre-installed:

1. The module `wikidataintegrator`, which should be installed locally, i.e.
  
```
pip install wikidataintegrator
```

2. The [Robot SPARQL query CLI tool](http://robot.obolibrary.org/)

3. The PyQuery module:

``` 
pip install pyquery
```

4. The dotenv module:

``` 
pip install python-dotenv
```

## Configuration and Meta-data Preparation the Data Processing Pipeline

The following data and meta-data downloading steps are required before post-processing operations are attempted.

First, copy the file `template.env` file into `.env` and customize it to the required release of SemMedDb, UMLS, MetaMap, etc.  This file contains environment variables imported by the Python module file **semmed_biolink_environment.py** to identify source (meta-)data to be processed by the Jupyter Notebook data processing pipeline.

The `.env` file is also consumed by the `setup_environment.sh` script, which should be run next using the *nix `source` command:

```bash
source ./setup_environment.sh
```

to set up additional OS environment variables used by data conversion. Inspect this script to better see which variables are set (and which may be overridden).

The following steps should be followed to download and pre-process the (meta-)data required for further data processing:

1. SemMedDb data files are accessed at the link provided ([https://ii.nlm.nih.gov/SemRep_SemMedDB_SKR/SemMedDB/SemMedDB_download.shtml](https://ii.nlm.nih.gov/SemRep_SemMedDB_SKR/SemMedDB/SemMedDB_download.shtml) as  of May 2021), the access to which will require you to log into NLM UTS (we assume that you are a registered user of the UTS, right?) then download the following target into your chosen working directory, URLs as defined by the specified environment variables (in CAPS below) which were set by the `setup_environment.sh` script:

    1. SEMMEDDB_PREDICATION_DOWNLOAD
    2. SEMMEDDB_PREDICATION_AUX_DOWNLOAD
    3. SEMMEDDB_SENTENCE_DOWNLOAD
    4. SEMMEDDB_CITATIONS_DOWNLOAD
    5. UMLS_DOWNLOAD

2. Download the following Unique Ingredient Identifier data in the  [UNII_Data.zip](https://fdasis.nlm.nih.gov/srs/download/srs/UNII_Data.zip) file from the FDA.

3. Download the following [OBO ontology file for Uberon](http://purl.obolibrary.org/obo/uberon.owl). After downloading these files, a CSV file must be generated using the 'robot' query tool, as follows (note that the obo_query.sparql file is in the root directory of this project)

```
robot query --input uberon.owl --query obo_query.sparql uberon.csv
```
    
4. Similarly, download the following [OBO ontology file for DOID](http://purl.obolibrary.org/obo/doid.owl). After downloading these files, a CSV file must be generated using the 'robot' query tool, as follows:

```
robot query --input doid.owl --query obo_query.sparql doid.csv
```
    
5. Run the `semmed_sql_to_csv.sh` script on each SemMedDb SQL file downloaded (which converts various SEMMEDDB\_\*\_ARCHIVE files to the corresponding SEMMEDDB\_\*\_CSV files).  Note: if CSV formatted files are initially downloaded,then this step is not required.

6. Manually unzip the UMLS_ARCHIVE, extracting the contained files into one folder (e.g. `2020AA-full`). Also unzip the embedded `mmsys.zip` archive. This archive contains the MetamorphoSys - The UMLS Installation and Customization Program which must now be used to generate the required Metathesaurus - Rich Release Format (RRF) files (see list below). Running the startup script for the 'mmsys' application (specific script for your chosen platform) brings up the Metamorphosys application dialog dialog box. Select "Install UMLS" and you only need to select the "Metathesaurus" option. When prompted for a configuration, selection "New Configuration" which will ask you to select the level of vocabulary extraction. You will need to  choose the "Level" of intellectual properly compliance compatible with your licensing and data distribution plans (for NCATS, where indicated, we use the full vocabulary including SNOMED). Modify any additional input and output details in the full dialog if necessary (input is NLM, output is RRF). Note that the extracted files should be in the directory set in the  **UMLS_PATH** variable set in the `semmed_biolink_environment.py` module (perhaps something like '_<project dir>/data/2020AA_Active_`).  After all parameters are set, initiate the subset generation (Note: the way to initiate this seems to subtly vary between operating systems, so read the [Metamorphosys documentation](https://www.nlm.nih.gov/research/umls/implementation_resources/metamorphosys/help.html) for clarification). After the vocabulary subsets are generated, apply the following (*nix OS) operations on the indicated "Rich Release Format" ("RRF") files that were generated by the above operation, to further prepare them for use in the SemMedDb processing protocols:

    1. gzip -c MRCONSO.RRF  > MRCONSO.RRF.gz
    2. gzip -c MRSAT.RRF > MRSAT.RRF.gz 
    3. cat MRCONSO.RRF | grep -F "|ENG|" | gzip > MRCONSO_ENG.RRF.gz
    4. gzip -c MRSTY.RRF > MRSTY.RRF.gz

## Data Processing Procedure

Run the following Jupiter Notebooks (ipynb's) in order

### 01-initial_data_clean.ipynb
- Expand predicates with OR operations into individual predicates
- Convert CUIs that are Entrez ids into CUIs
- Change neg props to the same prop with a negative flag
- Make a separate nodes table

### 02-normalize_node_types_to_biolink.ipynb
- For each node, get the UMLS semantic type for each umls cui
- Map UMLS semantic types to Biolink node types (blm_to_umls_nodes.json)
- Nodes with no matching type are removed

### 03-filter_nodes_edges.ipynb
- Remove edges with nodes with no umls type or label
- Remove the following predicates: ['compared_with', 'higher_than', 'lower_than', 'different_from', 'different_than', 
'same_as','OCCURS_IN', 'PROCESS_OF', 'DIAGNOSES', 'METHOD_OF', 'USES','AUGMENTS', 'ADMINISTERED_TO', 'COMPLICATES']

### 04-filter_biolink
 - Filter specific domain and ranges for: CAUSES, LOCATION_OF, TREATS, PREDISPOSES, PREVENTS
 - rename 'converts_to' edge to 'derives_into'
 - rename 'isa' edge to 'subclass of'
 - rename 'disrupts' edge to 'affects'
 - rename 'associated_with' edge to 'related_to'
 - rename 'STIMULATES' edge to 'positively_regulates'
 - rename 'INHIBITS' edge to 'negatively_regulates'
 - associated_with/related_to edges with domain: gene, range: disease; rename to gene_associated_with_condition

### 05-xrefs

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

## Options for Data Loading

There are now two final Jupyter workbooks preparing the data for data loading.  Note that the second option **06b-kgx-load** loading is now the preferred one being actively maintained (use the classical version only 'with a health warning').

### 06a-neo4j-classical-load
- reformat for neo4j import (old method, not using KGX)

### 06b-kgx-load
- This workbook finalizes the data format of the SemMedDb datasets for KGX import

