.. _ahelp_FATCAT_matplot:

**************
FATCAT_matplot
**************

.. contents:: 
    :depth: 4 

| 

.. code-block:: none

    
       ----------------------------------------------------------------------------
       FATCAT_matplot
          Launch a shiny app to visualize .netcc and/or .grid files.
          Takes one argument, a path to a folder with said files.
          That path MUST be the last argument!
          May need "@afni_R_package_install -shiny -circos" for R libraries.
    
       -----------------------------------------------------------------------------
       options:
          -help        : Show this help.
          -ShinyFolder : Use a custom shiny folder (for testing purposes).
    
       -----------------------------------------------------------------------------
       examples:
          FATCAT_matplot ~/disco_netcc_folder
    
       -----------------------------------------------------------------------------
       Justin Rajendra 11/2017
