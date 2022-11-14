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

* [PostgreSQL SQL Tricks](https://postgres.cz/wiki/PostgreSQL_SQL_Tricks) - Tips & Tricks on PostgreSQL
* [PostgreSQL Index Maintenance](https://wiki.postgresql.org/wiki/Index_Maintenance) - Index maintenance
* [Postgres Cheat Sheet](https://postgrescheatsheet.com/#/tables) - PGSQL cheat sheet
* [PGSQL commands & queries](https://dzone.com/articles/useful-postgresql-commandsqueries-part-1) - Useful commands & queries

## Réalisé avec

* [Git](https://git-scm.com)

## Contributions

Si vous souhaitez contribuer, lisez le fichier CONTRIBUTING.md pour savoir comment procéder.
