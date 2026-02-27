const Aggregate = @import("aggregate.zig").Aggregate;
const AmazonRedshiftSource = @import("amazon_redshift_source.zig").AmazonRedshiftSource;
const AmazonRedshiftTarget = @import("amazon_redshift_target.zig").AmazonRedshiftTarget;
const ApplyMapping = @import("apply_mapping.zig").ApplyMapping;
const AthenaConnectorSource = @import("athena_connector_source.zig").AthenaConnectorSource;
const CatalogDeltaSource = @import("catalog_delta_source.zig").CatalogDeltaSource;
const CatalogHudiSource = @import("catalog_hudi_source.zig").CatalogHudiSource;
const CatalogIcebergSource = @import("catalog_iceberg_source.zig").CatalogIcebergSource;
const CatalogKafkaSource = @import("catalog_kafka_source.zig").CatalogKafkaSource;
const CatalogKinesisSource = @import("catalog_kinesis_source.zig").CatalogKinesisSource;
const CatalogSource = @import("catalog_source.zig").CatalogSource;
const BasicCatalogTarget = @import("basic_catalog_target.zig").BasicCatalogTarget;
const ConnectorDataSource = @import("connector_data_source.zig").ConnectorDataSource;
const ConnectorDataTarget = @import("connector_data_target.zig").ConnectorDataTarget;
const CustomCode = @import("custom_code.zig").CustomCode;
const DirectJDBCSource = @import("direct_jdbc_source.zig").DirectJDBCSource;
const DirectKafkaSource = @import("direct_kafka_source.zig").DirectKafkaSource;
const DirectKinesisSource = @import("direct_kinesis_source.zig").DirectKinesisSource;
const DropDuplicates = @import("drop_duplicates.zig").DropDuplicates;
const DropFields = @import("drop_fields.zig").DropFields;
const DropNullFields = @import("drop_null_fields.zig").DropNullFields;
const DynamicTransform = @import("dynamic_transform.zig").DynamicTransform;
const DynamoDBCatalogSource = @import("dynamo_db_catalog_source.zig").DynamoDBCatalogSource;
const DynamoDBELTConnectorSource = @import("dynamo_dbelt_connector_source.zig").DynamoDBELTConnectorSource;
const EvaluateDataQuality = @import("evaluate_data_quality.zig").EvaluateDataQuality;
const EvaluateDataQualityMultiFrame = @import("evaluate_data_quality_multi_frame.zig").EvaluateDataQualityMultiFrame;
const FillMissingValues = @import("fill_missing_values.zig").FillMissingValues;
const Filter = @import("filter.zig").Filter;
const GovernedCatalogSource = @import("governed_catalog_source.zig").GovernedCatalogSource;
const GovernedCatalogTarget = @import("governed_catalog_target.zig").GovernedCatalogTarget;
const JDBCConnectorSource = @import("jdbc_connector_source.zig").JDBCConnectorSource;
const JDBCConnectorTarget = @import("jdbc_connector_target.zig").JDBCConnectorTarget;
const Join = @import("join.zig").Join;
const Merge = @import("merge.zig").Merge;
const MicrosoftSQLServerCatalogSource = @import("microsoft_sql_server_catalog_source.zig").MicrosoftSQLServerCatalogSource;
const MicrosoftSQLServerCatalogTarget = @import("microsoft_sql_server_catalog_target.zig").MicrosoftSQLServerCatalogTarget;
const MySQLCatalogSource = @import("my_sql_catalog_source.zig").MySQLCatalogSource;
const MySQLCatalogTarget = @import("my_sql_catalog_target.zig").MySQLCatalogTarget;
const OracleSQLCatalogSource = @import("oracle_sql_catalog_source.zig").OracleSQLCatalogSource;
const OracleSQLCatalogTarget = @import("oracle_sql_catalog_target.zig").OracleSQLCatalogTarget;
const PIIDetection = @import("pii_detection.zig").PIIDetection;
const PostgreSQLCatalogSource = @import("postgre_sql_catalog_source.zig").PostgreSQLCatalogSource;
const PostgreSQLCatalogTarget = @import("postgre_sql_catalog_target.zig").PostgreSQLCatalogTarget;
const Recipe = @import("recipe.zig").Recipe;
const RedshiftSource = @import("redshift_source.zig").RedshiftSource;
const RedshiftTarget = @import("redshift_target.zig").RedshiftTarget;
const RelationalCatalogSource = @import("relational_catalog_source.zig").RelationalCatalogSource;
const RenameField = @import("rename_field.zig").RenameField;
const Route = @import("route.zig").Route;
const S3CatalogDeltaSource = @import("s3_catalog_delta_source.zig").S3CatalogDeltaSource;
const S3CatalogHudiSource = @import("s3_catalog_hudi_source.zig").S3CatalogHudiSource;
const S3CatalogIcebergSource = @import("s3_catalog_iceberg_source.zig").S3CatalogIcebergSource;
const S3CatalogSource = @import("s3_catalog_source.zig").S3CatalogSource;
const S3CatalogTarget = @import("s3_catalog_target.zig").S3CatalogTarget;
const S3CsvSource = @import("s3_csv_source.zig").S3CsvSource;
const S3DeltaCatalogTarget = @import("s3_delta_catalog_target.zig").S3DeltaCatalogTarget;
const S3DeltaDirectTarget = @import("s3_delta_direct_target.zig").S3DeltaDirectTarget;
const S3DeltaSource = @import("s3_delta_source.zig").S3DeltaSource;
const S3DirectTarget = @import("s3_direct_target.zig").S3DirectTarget;
const S3ExcelSource = @import("s3_excel_source.zig").S3ExcelSource;
const S3GlueParquetTarget = @import("s3_glue_parquet_target.zig").S3GlueParquetTarget;
const S3HudiCatalogTarget = @import("s3_hudi_catalog_target.zig").S3HudiCatalogTarget;
const S3HudiDirectTarget = @import("s3_hudi_direct_target.zig").S3HudiDirectTarget;
const S3HudiSource = @import("s3_hudi_source.zig").S3HudiSource;
const S3HyperDirectTarget = @import("s3_hyper_direct_target.zig").S3HyperDirectTarget;
const S3IcebergCatalogTarget = @import("s3_iceberg_catalog_target.zig").S3IcebergCatalogTarget;
const S3IcebergDirectTarget = @import("s3_iceberg_direct_target.zig").S3IcebergDirectTarget;
const S3JsonSource = @import("s3_json_source.zig").S3JsonSource;
const S3ParquetSource = @import("s3_parquet_source.zig").S3ParquetSource;
const SelectFields = @import("select_fields.zig").SelectFields;
const SelectFromCollection = @import("select_from_collection.zig").SelectFromCollection;
const SnowflakeSource = @import("snowflake_source.zig").SnowflakeSource;
const SnowflakeTarget = @import("snowflake_target.zig").SnowflakeTarget;
const SparkConnectorSource = @import("spark_connector_source.zig").SparkConnectorSource;
const SparkConnectorTarget = @import("spark_connector_target.zig").SparkConnectorTarget;
const SparkSQL = @import("spark_sql.zig").SparkSQL;
const Spigot = @import("spigot.zig").Spigot;
const SplitFields = @import("split_fields.zig").SplitFields;
const Union = @import("union.zig").Union;

/// `CodeGenConfigurationNode` enumerates all valid Node types. One and only one
/// of its member variables can be populated.
pub const CodeGenConfigurationNode = struct {
    /// Specifies a transform that groups rows by chosen fields and computes the
    /// aggregated value by specified function.
    aggregate: ?Aggregate,

    /// Specifies a target that writes to a data source in Amazon Redshift.
    amazon_redshift_source: ?AmazonRedshiftSource,

    /// Specifies a target that writes to a data target in Amazon Redshift.
    amazon_redshift_target: ?AmazonRedshiftTarget,

    /// Specifies a transform that maps data property keys in the data source to
    /// data property keys in the data target. You can rename keys, modify the data
    /// types for keys, and choose which keys to drop from the dataset.
    apply_mapping: ?ApplyMapping,

    /// Specifies a connector to an Amazon Athena data source.
    athena_connector_source: ?AthenaConnectorSource,

    /// Specifies a Delta Lake data source that is registered in the Glue Data
    /// Catalog.
    catalog_delta_source: ?CatalogDeltaSource,

    /// Specifies a Hudi data source that is registered in the Glue Data Catalog.
    catalog_hudi_source: ?CatalogHudiSource,

    /// Specifies an Apache Iceberg data source that is registered in the Glue Data
    /// Catalog.
    catalog_iceberg_source: ?CatalogIcebergSource,

    /// Specifies an Apache Kafka data store in the Data Catalog.
    catalog_kafka_source: ?CatalogKafkaSource,

    /// Specifies a Kinesis data source in the Glue Data Catalog.
    catalog_kinesis_source: ?CatalogKinesisSource,

    /// Specifies a data store in the Glue Data Catalog.
    catalog_source: ?CatalogSource,

    /// Specifies a target that uses a Glue Data Catalog table.
    catalog_target: ?BasicCatalogTarget,

    /// Specifies a source generated with standard connection options.
    connector_data_source: ?ConnectorDataSource,

    /// Specifies a target generated with standard connection options.
    connector_data_target: ?ConnectorDataTarget,

    /// Specifies a transform that uses custom code you provide to perform the data
    /// transformation. The output is a collection of DynamicFrames.
    custom_code: ?CustomCode,

    direct_jdbc_source: ?DirectJDBCSource,

    /// Specifies an Apache Kafka data store.
    direct_kafka_source: ?DirectKafkaSource,

    /// Specifies a direct Amazon Kinesis data source.
    direct_kinesis_source: ?DirectKinesisSource,

    /// Specifies a transform that removes rows of repeating data from a data set.
    drop_duplicates: ?DropDuplicates,

    /// Specifies a transform that chooses the data property keys that you want to
    /// drop.
    drop_fields: ?DropFields,

    /// Specifies a transform that removes columns from the dataset if all values in
    /// the column are 'null'. By default, Glue Studio will recognize null objects,
    /// but some values such as empty strings, strings that are "null", -1 integers
    /// or other placeholders such as zeros, are not automatically recognized as
    /// nulls.
    drop_null_fields: ?DropNullFields,

    /// Specifies a custom visual transform created by a user.
    dynamic_transform: ?DynamicTransform,

    /// Specifies a DynamoDBC Catalog data store in the Glue Data Catalog.
    dynamo_db_catalog_source: ?DynamoDBCatalogSource,

    /// Specifies a DynamoDB ELT connector source for extracting data from DynamoDB
    /// tables.
    dynamo_dbelt_connector_source: ?DynamoDBELTConnectorSource,

    /// Specifies your data quality evaluation criteria.
    evaluate_data_quality: ?EvaluateDataQuality,

    /// Specifies your data quality evaluation criteria. Allows multiple input data
    /// and returns a collection of Dynamic Frames.
    evaluate_data_quality_multi_frame: ?EvaluateDataQualityMultiFrame,

    /// Specifies a transform that locates records in the dataset that have missing
    /// values and adds a new field with a value determined by imputation. The input
    /// data set is used to train the machine learning model that determines what
    /// the missing value should be.
    fill_missing_values: ?FillMissingValues,

    /// Specifies a transform that splits a dataset into two, based on a filter
    /// condition.
    filter: ?Filter,

    /// Specifies a data source in a goverened Data Catalog.
    governed_catalog_source: ?GovernedCatalogSource,

    /// Specifies a data target that writes to a goverened catalog.
    governed_catalog_target: ?GovernedCatalogTarget,

    /// Specifies a connector to a JDBC data source.
    jdbc_connector_source: ?JDBCConnectorSource,

    /// Specifies a data target that writes to Amazon S3 in Apache Parquet columnar
    /// storage.
    jdbc_connector_target: ?JDBCConnectorTarget,

    /// Specifies a transform that joins two datasets into one dataset using a
    /// comparison phrase on the specified data property keys. You can use inner,
    /// outer, left, right, left semi, and left anti joins.
    join: ?Join,

    /// Specifies a transform that merges a `DynamicFrame` with a staging
    /// `DynamicFrame` based on the specified primary keys to identify records.
    /// Duplicate records (records with the same primary keys) are not
    /// de-duplicated.
    merge: ?Merge,

    /// Specifies a Microsoft SQL server data source in the Glue Data Catalog.
    microsoft_sql_server_catalog_source: ?MicrosoftSQLServerCatalogSource,

    /// Specifies a target that uses Microsoft SQL.
    microsoft_sql_server_catalog_target: ?MicrosoftSQLServerCatalogTarget,

    /// Specifies a MySQL data source in the Glue Data Catalog.
    my_sql_catalog_source: ?MySQLCatalogSource,

    /// Specifies a target that uses MySQL.
    my_sql_catalog_target: ?MySQLCatalogTarget,

    /// Specifies an Oracle data source in the Glue Data Catalog.
    oracle_sql_catalog_source: ?OracleSQLCatalogSource,

    /// Specifies a target that uses Oracle SQL.
    oracle_sql_catalog_target: ?OracleSQLCatalogTarget,

    /// Specifies a transform that identifies, removes or masks PII data.
    pii_detection: ?PIIDetection,

    /// Specifies a PostgresSQL data source in the Glue Data Catalog.
    postgre_sql_catalog_source: ?PostgreSQLCatalogSource,

    /// Specifies a target that uses Postgres SQL.
    postgre_sql_catalog_target: ?PostgreSQLCatalogTarget,

    /// Specifies a Glue DataBrew recipe node.
    recipe: ?Recipe,

    /// Specifies an Amazon Redshift data store.
    redshift_source: ?RedshiftSource,

    /// Specifies a target that uses Amazon Redshift.
    redshift_target: ?RedshiftTarget,

    /// Specifies a relational catalog data store in the Glue Data Catalog.
    relational_catalog_source: ?RelationalCatalogSource,

    /// Specifies a transform that renames a single data property key.
    rename_field: ?RenameField,

    /// Specifies a route node that directs data to different output paths based on
    /// defined filtering conditions.
    route: ?Route,

    /// Specifies a Delta Lake data source that is registered in the Glue Data
    /// Catalog. The data source must be stored in Amazon S3.
    s3_catalog_delta_source: ?S3CatalogDeltaSource,

    /// Specifies a Hudi data source that is registered in the Glue Data Catalog.
    /// The data source must be stored in Amazon S3.
    s3_catalog_hudi_source: ?S3CatalogHudiSource,

    /// Specifies an Apache Iceberg data source that is registered in the Glue Data
    /// Catalog. The Iceberg data source must be stored in Amazon S3.
    s3_catalog_iceberg_source: ?S3CatalogIcebergSource,

    /// Specifies an Amazon S3 data store in the Glue Data Catalog.
    s3_catalog_source: ?S3CatalogSource,

    /// Specifies a data target that writes to Amazon S3 using the Glue Data
    /// Catalog.
    s3_catalog_target: ?S3CatalogTarget,

    /// Specifies a command-separated value (CSV) data store stored in Amazon S3.
    s3_csv_source: ?S3CsvSource,

    /// Specifies a target that writes to a Delta Lake data source in the Glue Data
    /// Catalog.
    s3_delta_catalog_target: ?S3DeltaCatalogTarget,

    /// Specifies a target that writes to a Delta Lake data source in Amazon S3.
    s3_delta_direct_target: ?S3DeltaDirectTarget,

    /// Specifies a Delta Lake data source stored in Amazon S3.
    s3_delta_source: ?S3DeltaSource,

    /// Specifies a data target that writes to Amazon S3.
    s3_direct_target: ?S3DirectTarget,

    /// Defines configuration parameters for reading Excel files from Amazon S3.
    s3_excel_source: ?S3ExcelSource,

    /// Specifies a data target that writes to Amazon S3 in Apache Parquet columnar
    /// storage.
    s3_glue_parquet_target: ?S3GlueParquetTarget,

    /// Specifies a target that writes to a Hudi data source in the Glue Data
    /// Catalog.
    s3_hudi_catalog_target: ?S3HudiCatalogTarget,

    /// Specifies a target that writes to a Hudi data source in Amazon S3.
    s3_hudi_direct_target: ?S3HudiDirectTarget,

    /// Specifies a Hudi data source stored in Amazon S3.
    s3_hudi_source: ?S3HudiSource,

    /// Defines configuration parameters for writing data to Amazon S3 using
    /// HyperDirect optimization.
    s3_hyper_direct_target: ?S3HyperDirectTarget,

    /// Specifies an Apache Iceberg catalog target that writes data to Amazon S3 and
    /// registers the table in the Glue Data Catalog.
    s3_iceberg_catalog_target: ?S3IcebergCatalogTarget,

    /// Defines configuration parameters for writing data to Amazon S3 as an Apache
    /// Iceberg table.
    s3_iceberg_direct_target: ?S3IcebergDirectTarget,

    /// Specifies a JSON data store stored in Amazon S3.
    s3_json_source: ?S3JsonSource,

    /// Specifies an Apache Parquet data store stored in Amazon S3.
    s3_parquet_source: ?S3ParquetSource,

    /// Specifies a transform that chooses the data property keys that you want to
    /// keep.
    select_fields: ?SelectFields,

    /// Specifies a transform that chooses one `DynamicFrame` from a collection of
    /// `DynamicFrames`. The output is the selected `DynamicFrame`
    select_from_collection: ?SelectFromCollection,

    /// Specifies a Snowflake data source.
    snowflake_source: ?SnowflakeSource,

    /// Specifies a target that writes to a Snowflake data source.
    snowflake_target: ?SnowflakeTarget,

    /// Specifies a connector to an Apache Spark data source.
    spark_connector_source: ?SparkConnectorSource,

    /// Specifies a target that uses an Apache Spark connector.
    spark_connector_target: ?SparkConnectorTarget,

    /// Specifies a transform where you enter a SQL query using Spark SQL syntax to
    /// transform the data. The output is a single `DynamicFrame`.
    spark_sql: ?SparkSQL,

    /// Specifies a transform that writes samples of the data to an Amazon S3
    /// bucket.
    spigot: ?Spigot,

    /// Specifies a transform that splits data property keys into two
    /// `DynamicFrames`. The output is a collection of `DynamicFrames`: one with
    /// selected data property keys, and one with the remaining data property keys.
    split_fields: ?SplitFields,

    /// Specifies a transform that combines the rows from two or more datasets into
    /// a single result.
    @"union": ?Union,

    pub const json_field_names = .{
        .aggregate = "Aggregate",
        .amazon_redshift_source = "AmazonRedshiftSource",
        .amazon_redshift_target = "AmazonRedshiftTarget",
        .apply_mapping = "ApplyMapping",
        .athena_connector_source = "AthenaConnectorSource",
        .catalog_delta_source = "CatalogDeltaSource",
        .catalog_hudi_source = "CatalogHudiSource",
        .catalog_iceberg_source = "CatalogIcebergSource",
        .catalog_kafka_source = "CatalogKafkaSource",
        .catalog_kinesis_source = "CatalogKinesisSource",
        .catalog_source = "CatalogSource",
        .catalog_target = "CatalogTarget",
        .connector_data_source = "ConnectorDataSource",
        .connector_data_target = "ConnectorDataTarget",
        .custom_code = "CustomCode",
        .direct_jdbc_source = "DirectJDBCSource",
        .direct_kafka_source = "DirectKafkaSource",
        .direct_kinesis_source = "DirectKinesisSource",
        .drop_duplicates = "DropDuplicates",
        .drop_fields = "DropFields",
        .drop_null_fields = "DropNullFields",
        .dynamic_transform = "DynamicTransform",
        .dynamo_db_catalog_source = "DynamoDBCatalogSource",
        .dynamo_dbelt_connector_source = "DynamoDBELTConnectorSource",
        .evaluate_data_quality = "EvaluateDataQuality",
        .evaluate_data_quality_multi_frame = "EvaluateDataQualityMultiFrame",
        .fill_missing_values = "FillMissingValues",
        .filter = "Filter",
        .governed_catalog_source = "GovernedCatalogSource",
        .governed_catalog_target = "GovernedCatalogTarget",
        .jdbc_connector_source = "JDBCConnectorSource",
        .jdbc_connector_target = "JDBCConnectorTarget",
        .join = "Join",
        .merge = "Merge",
        .microsoft_sql_server_catalog_source = "MicrosoftSQLServerCatalogSource",
        .microsoft_sql_server_catalog_target = "MicrosoftSQLServerCatalogTarget",
        .my_sql_catalog_source = "MySQLCatalogSource",
        .my_sql_catalog_target = "MySQLCatalogTarget",
        .oracle_sql_catalog_source = "OracleSQLCatalogSource",
        .oracle_sql_catalog_target = "OracleSQLCatalogTarget",
        .pii_detection = "PIIDetection",
        .postgre_sql_catalog_source = "PostgreSQLCatalogSource",
        .postgre_sql_catalog_target = "PostgreSQLCatalogTarget",
        .recipe = "Recipe",
        .redshift_source = "RedshiftSource",
        .redshift_target = "RedshiftTarget",
        .relational_catalog_source = "RelationalCatalogSource",
        .rename_field = "RenameField",
        .route = "Route",
        .s3_catalog_delta_source = "S3CatalogDeltaSource",
        .s3_catalog_hudi_source = "S3CatalogHudiSource",
        .s3_catalog_iceberg_source = "S3CatalogIcebergSource",
        .s3_catalog_source = "S3CatalogSource",
        .s3_catalog_target = "S3CatalogTarget",
        .s3_csv_source = "S3CsvSource",
        .s3_delta_catalog_target = "S3DeltaCatalogTarget",
        .s3_delta_direct_target = "S3DeltaDirectTarget",
        .s3_delta_source = "S3DeltaSource",
        .s3_direct_target = "S3DirectTarget",
        .s3_excel_source = "S3ExcelSource",
        .s3_glue_parquet_target = "S3GlueParquetTarget",
        .s3_hudi_catalog_target = "S3HudiCatalogTarget",
        .s3_hudi_direct_target = "S3HudiDirectTarget",
        .s3_hudi_source = "S3HudiSource",
        .s3_hyper_direct_target = "S3HyperDirectTarget",
        .s3_iceberg_catalog_target = "S3IcebergCatalogTarget",
        .s3_iceberg_direct_target = "S3IcebergDirectTarget",
        .s3_json_source = "S3JsonSource",
        .s3_parquet_source = "S3ParquetSource",
        .select_fields = "SelectFields",
        .select_from_collection = "SelectFromCollection",
        .snowflake_source = "SnowflakeSource",
        .snowflake_target = "SnowflakeTarget",
        .spark_connector_source = "SparkConnectorSource",
        .spark_connector_target = "SparkConnectorTarget",
        .spark_sql = "SparkSQL",
        .spigot = "Spigot",
        .split_fields = "SplitFields",
        .@"union" = "Union",
    };
};
