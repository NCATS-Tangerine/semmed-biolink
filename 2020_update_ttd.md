# 2020 SemMedDb Biolink KG Update Notes

July 2020

## Caveat emptor
Here just a few stray thoughts about quality assurance in the data conversion pipeline. Note that the initial pipeline was developed by  Greg Stupp while he was at SCRIPPS (in Su Lab) and the updated version is by R. Bruskiewich of STAR Informatics. The latter person (RB) doesn't claim to have deeply understood every single transformation step, let alone deeply reviewing the consequences of each step on the propagation of the raw SemMedDb dataset. Here are a few thoughts on what such a review could (should?) actually entail, for each workbook step, as well any other proposed enhancements of the pipeline.

## Software Configuration

The project has been partially parameterized. Initially, a `setup_environment.sh` script  formulates the key environment variable values which could (should) drive the data conversion but these are not yet automatically tied into the Jupyter Notebook configuration.

On this latter concern, a preliminary step was taken to externalize input data (SemMedDb, UMLS, etc.) data releases and data pipeline file names, in a Python module in the root project folder called `semmed_biolink_environment.py`, which is imported by all the notebooks for local use.  This module is (as of July 7, 2020) only hardcoded for data releases and general data location. This basic module could be elaborated with some suitable mechanism of (documented) environment variable settings.

## 01-initial_data_clean.ipynb

1. Somewhere in between step 7 and 13, the dataset ends up with about 1100 edges with empty subject and/or empty object CUI. These are easily eliminated but the specific source of this defect is not diagnosed (could there be some consequential loss of data?)
2. By step 20, about 18,000 subjects lack mappings to UMLS 'C' identifiers, thus removing about 37,800 edges from the dataset (undiagnosed).

## 02-normalize_node_types_to_biolink.ipynb

Nothing to comment here yet.

## 03-filter_nodes_edges.ipynb

1. Step 5 _removes_ over 7,403,000 (almost 1/3) edges from consideration,  based on whether or not they contain concept identifiers resolved in the nodes list from previous steps. This seems a bit large (undiagnosed).
2. Step 8 - predicates removed - could be reviewed for continuing relevance, since a further 1.4 million edges are removed from  consideration at this point (alongside some node id records now ignored).

## 04-filter_biolink.ipynb

Nothing yet to comment here except that the various filters could be reviewed for accuracy and relevance (essentially unchanged semantically from original Greg Stupp release) given that at least 115,000 additional edges are removed.

## 05-xrefs.ipynb

1. The 'tqdm' progress of step 32 behaves a bit strangely (not monotonically increasing, and resetting) but the result of the step seems ok (but may be worth a review?)


## 06b-kgx-load.ipynb
