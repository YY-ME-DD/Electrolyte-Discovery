# Electrolyte-Discovery

Code for 'Machine Learning Accelerates High-Voltage Electrolyte Discovery for Lithium Metal Batteries'

# Machine learning model
**Main code:** 'RF_model.m'  
**Electrolytes dataset:** 'Data_electrolytes.xlsx'  

Please place 'RF_model.m' and 'Data_electrolytes.xlsx' in the same file.  

The performance prediction model for electrolyte can be established using 'RF_model.m'.  

# Electrolyte formulation solutioin

**Main code:** 'main.m'  
**Fuction:** 2.1. initpop, 2.2. calobjvalue, 2.2.1. decodechrom, 2.2.2. decodebinary, 2.3. calfitvalue, 2.4. division, 2.5. differentiation, 2.6. conversion, 2.7. best.  

After running the 'RF_model', the electrolyte formulation can be determined using the 'main' code in the 'SCD algorithm' file.  
