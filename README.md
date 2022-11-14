# Tips & Tricks

Quelques trucs et astuces sur certains langages, outils, ...

[![forthebadge](https://forthebadge.com/images/badges/you-didnt-ask-for-this.svg)](http://forthebadge.com) [![forthebadge](https://forthebadge.com/images/badges/contains-technical-debt.svg)](http://forthebadge.com)  [![forthebadge](https://forthebadge.com/images/badges/check-it-out.svg)](http://forthebadge.com)  [![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](http://forthebadge.com)

![Tips & Tricks](./images/social-preview-640-500.png)

## IBM DB2

![IBM DB2](./images/db2-logo-256.png)

### Scripts utiles

* [Rechercher une colonne dans la base de données](./scripts/db2/column-search.sql)
* [Obtenir une ordre SQL de CREATE TABLE d'une table](./scripts/db2/create-table-from-db2-structure.sql)
* [Compter le nombre de colonnes](./scripts/db2/count-columns-per-table.sql) par table

## PostgreSQL

![PostgreSQL](./images/postgresql-logo-256.png)

### Scripts utiles

#### Audit

* [Obtient les statistiques de contenu d'une table](./scripts/postgresql/audit/table-statistics.sql)
* [Vérifier le fillfactor pour chaque tables et index de la base de données](./scripts/postgresql/audit/fill-factor-value.sql)
* [Trouver les index en doublon](./scripts/postgresql/audit/duplicate-indexes.sql)
* [Trouver les index inutiles](./scripts/postgresql/audit/useless-indexes.sql)
* [Obtenir la structure de la table](./scripts/postgresql/audit/table-structure.sql)
* [Obtenir les statistiques d'utilisation](./scripts/postgresql/audit/index-usage-statistics.sql)
* [Les tables sur lesquelles il manque un index](./scripts/postgresql/audit/tables-need-indexing.sql)
* [Retourner les tables sur lesquelles il manque une clé primaire ou une clé unique](./scripts/postgresql/audit/tables-without-pk-ui.sql)
* [Retourner les tables sur lesquelles il manque une clé primaire](./scripts/postgresql/audit/tables-without-pk.sql)
* [Retourner les tables avec des champs de type Geometry non indexés](./scripts/postgresql/audit/tables-without-indexes-on-geometry.sql)
* [Trouver les tables avec le plus de fragmentation](./scripts/postgresql/audit/find_bloated_tables.sql)
* [Trouver les index manquants](./scripts/postgresql/audit/missing-indexes.sql)
* [Rechercher une valeur dans les colonnes d'une table](./scripts/postgresql/audit/search-in-every-field-in-a-table.sql)

#### Taille

* [Vérifier la taille de la base de données](./scripts/postgresql/size-related-issues/db-size.sql)
* [Obtenir le nombre de bits gaspillés](./scripts/postgresql/size-related-issues/wasted-bytes.sql)
* [Quelle table a le plus de dead tuples](./scripts/postgresql/size-related-issues/dead-tuples.sql)
* [Quelle table ou index consomme le plus d'espace](./scripts/postgresql/size-related-issues/most-space.sql)

#### Performance

* [Top 10 des requêtes les plus longues](./scripts/postgresql/performance-related-issues/top-10-longest-queries.sql)
* [Obtenir les requêtes en cours d'exécution et les statuts de verrouillage](./scripts/postgresql/performance-related-issues/running-queries.sql)
* [Tuer une requête](./scripts/postgresql/performance-related-issues/kill.sql)

#### Securité

* [Retourne les autorisations par utilisateur](./scripts/postgresql/security/user-grants.sql)

### Liens utiles

* [PostgreSQL SQL Tricks](https://postgres.cz/wiki/PostgreSQL_SQL_Tricks) - Tips & Tricks
* [PostgreSQL Index Maintenance](https://wiki.postgresql.org/wiki/Index_Maintenance) - Maintenance des index
* [Postgres Cheat Sheet](https://postgrescheatsheet.com/#/tables) - PGSQL cheat sheet
* [PGSQL commands & queries](https://dzone.com/articles/useful-postgresql-commandsqueries-part-1) - Commandes et requêtes utiles

## Elastic

![Elastic](./images/elastic-logo-256.png)

### Liens utiles

* [Kibana best practices](https://www.elastic.co/guide/en/kibana/master/development-best-practices.html) - Les bonnes pratiques d'Elastic

## Qlik Sense

![Qlik](./images/qlik-logo-256.png)

### Documents utiles

* [Qlik Sense template](./qvf/template.qvf) - Un modèle de document Qlik Sense

### Liens utiles

* [Qlik Sense Demo](https://demos.qlik.com/qliksense) - Exemples de réalisations avec Qlik Sense

### Outils utiles

* [SenseTheme](https://sensetheme.com/) - Un générateur de thèmes pour Qlik Sense

## Qlikview

![Qlik](./images/qlik-logo-256.png)

### Documents utiles

* [DocumentAnalyzer_V1.14](./qvw/DocumentAnalyzer_V1.14.qvw) - Ce document peut analyser les champs utilisées dans un autre document QVW 
* [QvsEditor_v1.2](./qvw/QvsEditor_v1.2.qvw) - Ce document peut éditer les fichiers QVS (Qlikview scripts)
* [QVD Dictionary V2](./qvw/QVD_Dictionary_V2.qvw) - Ce document peut scanner les fichiers QVD/QVW pour construire un dictionnaire de données
* [Human Resources](./qvw/Human_Resources.qvw) - Un exemple de tableau de bord
* [Master Calendar](./qvw/qlik-calendar.qvw) - Construire un calendrier maître avec Qlikview
* [CSV to QVD generator](./qvw/convert_csv_to_qvd.qvw) - Convertir des fichiers CSV au format QVD
* [External Expressions](./qvw/external_expressions.qvw) - Externaliser les expressions
* [Central KPI formula repository](./qvw/kpi_formula_generator.qvw)
* [SQL to QVD generator](./qvw/qvd_generator.qvw) - Convertir des tables au format QVD

### Liens utiles

* [Qlikview Cookbook](https://qlikviewcookbook.com/) - Plusieurs recettes sur Qlik
* [Living QlikView](http://livingqlikview.com/19-tips-all-qlikview-beginners-must-know/) - Trucs et astuces que tout débutant devrait connaitre
* [Central KPI formula repository](https://community.qlik.com/t5/Deployment-Framework/Central-KPI-Formula-Repository-solution/td-p/1478681)
* [QlikView Demo](https://demos.qlik.com/qlikview) - Exemples de réalisation avec QlikView
* [Living Qlik](http://livingqlikview.com/) - A blog about Qlik
* [QuickIntelligence](https://www.quickintelligence.co.uk/examples/) - Exemples de réalisation avec QlikView
* [IPPON Qlikview Blog](https://blog.ipponservices.com/) - Un blog sur QlikView
* [Qlik Blog](http://www.qlikblog.at/) - Un autre blog sur QlikView
* [World Football Fan App](https://eu-b.demo.qlik.com/QvAJAXZfc/opendoc.htm?document=qvdocs/Choose%20Your%20Champion.qvw&sourceID1=mkto-2014-H1-World-Football)

### Outils utiles

* [EasyQlik QViewer](https://www.easyqlik.com/) - Un Viewer de QVD
* [Set Analysis Wizard for QlikView](http://tools.qlikblog.at/SetAnalysisWizard/QlikView-SetAnalysis_Wizard_and_Generator.aspx?sa=) - Un assistant pour les SetAnalysis
* [Nested If Generator](http://www.qlikblog.at/tools/Nested-If-Generator.html) - Un assistant pour les If imbriqués

### Scripts utiles

* Build a calendar
* Play with mapping
* Reset an inputfield

### Macros utiles

* Add conditionnal expression to chart
* Set up autozoom
* Change layout 
* Clone a dimension group
* Delete a file
* Dynamic Update
* Export object from hidden sheet to jpg
* Export object to Excel
* Export object to jpg
* Import/Export all variables
* Open a document with current month selection
* Open/Reload/Click/Close
* Read & write a variable
* Run an external program
* Save & exit Qlikview
* Send mail

## SQL

![SQL](./images/sql-logo-256.png)

### Liens utiles

* [SQLPro](https://sqlpro.developpez.com/) - Une bible en français sur le SQL
* [SQLPro Forum](https://www.developpez.net/forums/u3170/sqlpro/) - Un forum bien utile sur SQL
* [SqLines](http://www.sqlines.com/online) - Convertir une instruction SQL d'un SGBDR vers un autre SGBDR (Oracle vers SQL Server, SQL Server vers PostgreSQL, ...)
* [DBMS Tools](https://dbmstools.com/) - Une liste des outils autour des bases de données

### Outils utiles

* [FlyWay](https://flywaydb.org/) - Un outil open-source de maintien de base de données, avec des scripts de migration, des scripts rejouables, des scripts d'annulation ...

## Neo4j

![Neo4j](./images/neo4j-logo-256.png)

### Scripts utiles

* [Data dictionnary (tables)](./scripts/data-dictionnary-tables.sql)
* [Data dictionnary (relations)](./scripts/data-dictionnary-relations.sql)
* [Build nodes & edges](./scripts/build-nodes-and-edges.sql)
* [Delete existing nodes & edges](./scripts/delete-existing-nodes-edges.sql)
* [Rebuild all nodes & edges](./scripts/rebuild-all-nodes-and-edges.sql)

### Liens utiles

* [Neo4j Blog](https://neo4j.com/blog/) - A blog about Neo4j ;)
* [Graph visualization](https://neo4j.com/blog/graph-visualization-neo4j-schemas-yfiles/)
* [Data Integration](https://neo4j.com/data-integration/)
* [Synbioz Blog](https://www.synbioz.com/blog/tech/introduction-graph-db) - An introduction to graph-db
* [ETL](https://neo4j.com/developer/neo4j-etl/)

## Oracle Data Integrator

![Oracle Data Integrator](./images/odi-logo-128.png)

### Scripts utiles

* [Retrieve the last session per scenario](./scripts/retrieve-last-session-per-scenario.sql)
* [Analyze the KM used in the interfaces](./scripts/analyze-km.sql)
* [Check the properties of the table columns](./scripts/check-properties-of-columns.sql)
* [Compare the last modification dates of the objects](./scripts/compare-last-modification-date.sql)
* [Data lineage](./scripts/data-lineage.sql)
* [Key and check not null option on target columns](./scripts/key-and-cnn-option-on-target-columns.sql)
* [List of models, sub-models and tables with the corresponding parent folders and last userdate details](./scripts/list-models.sql)
* [Retrieve the list of interfaces in ODI](./scripts/retrieve-interfaces.sql)
* [Retrieve the list of scenarios in ODI](./scripts/retrieve-scenarios.sql)
* [Retrieve the list of tables in ODI](./scripts/retrieve-tables.sql)
* [Show the actual target mappings of the interfaces](./scripts/show-actual-target-mappings.sql)
* [Introspection](./scripts/introspection.sql)

### Liens utiles

* [Help Center Oracle Data Integrator](https://docs.oracle.com/en/middleware/fusion-middleware/data-integrator/index.html)
* [A blog about ODI](https://www.clearpeaks.com/?s=odi)

## Système & Réseau

![System](https://media.giphy.com/media/gI00zO3lxE01GL5m7O/giphy.gif)

### Scripts utiles

* [Obtenir la clé Wifi](./scripts/system/netsh_wlan_show_profile.bat) d'un SID

```bat
netsh wlan show profile name=SID key=clear
```

## Réalisé avec

* [Git](https://git-scm.com)

## Contributions

Si vous souhaitez contribuer, lisez le fichier CONTRIBUTING.md pour savoir comment procéder.
