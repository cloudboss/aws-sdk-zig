const AmazonElasticsearchParameters = @import("amazon_elasticsearch_parameters.zig").AmazonElasticsearchParameters;
const AmazonOpenSearchParameters = @import("amazon_open_search_parameters.zig").AmazonOpenSearchParameters;
const AthenaParameters = @import("athena_parameters.zig").AthenaParameters;
const AuroraParameters = @import("aurora_parameters.zig").AuroraParameters;
const AuroraPostgreSqlParameters = @import("aurora_postgre_sql_parameters.zig").AuroraPostgreSqlParameters;
const AwsIotAnalyticsParameters = @import("aws_iot_analytics_parameters.zig").AwsIotAnalyticsParameters;
const BigQueryParameters = @import("big_query_parameters.zig").BigQueryParameters;
const ConfluenceParameters = @import("confluence_parameters.zig").ConfluenceParameters;
const CustomConnectionParameters = @import("custom_connection_parameters.zig").CustomConnectionParameters;
const DatabricksParameters = @import("databricks_parameters.zig").DatabricksParameters;
const ExasolParameters = @import("exasol_parameters.zig").ExasolParameters;
const ImpalaParameters = @import("impala_parameters.zig").ImpalaParameters;
const JiraParameters = @import("jira_parameters.zig").JiraParameters;
const MariaDbParameters = @import("maria_db_parameters.zig").MariaDbParameters;
const MySqlParameters = @import("my_sql_parameters.zig").MySqlParameters;
const OracleParameters = @import("oracle_parameters.zig").OracleParameters;
const PostgreSqlParameters = @import("postgre_sql_parameters.zig").PostgreSqlParameters;
const PrestoParameters = @import("presto_parameters.zig").PrestoParameters;
const QBusinessParameters = @import("q_business_parameters.zig").QBusinessParameters;
const RdsParameters = @import("rds_parameters.zig").RdsParameters;
const RedshiftParameters = @import("redshift_parameters.zig").RedshiftParameters;
const S3KnowledgeBaseParameters = @import("s3_knowledge_base_parameters.zig").S3KnowledgeBaseParameters;
const S3Parameters = @import("s3_parameters.zig").S3Parameters;
const ServiceNowParameters = @import("service_now_parameters.zig").ServiceNowParameters;
const SnowflakeParameters = @import("snowflake_parameters.zig").SnowflakeParameters;
const SparkParameters = @import("spark_parameters.zig").SparkParameters;
const SqlServerParameters = @import("sql_server_parameters.zig").SqlServerParameters;
const StarburstParameters = @import("starburst_parameters.zig").StarburstParameters;
const TeradataParameters = @import("teradata_parameters.zig").TeradataParameters;
const TrinoParameters = @import("trino_parameters.zig").TrinoParameters;
const TwitterParameters = @import("twitter_parameters.zig").TwitterParameters;
const WebCrawlerParameters = @import("web_crawler_parameters.zig").WebCrawlerParameters;

/// The parameters that Quick Sight uses to connect to your underlying data
/// source.
/// This is a variant type structure. For this structure to be valid, only one
/// of the
/// attributes can be non-null.
pub const DataSourceParameters = union(enum) {
    /// The parameters for OpenSearch.
    amazon_elasticsearch_parameters: ?AmazonElasticsearchParameters,
    /// The parameters for OpenSearch.
    amazon_open_search_parameters: ?AmazonOpenSearchParameters,
    /// The parameters for Amazon Athena.
    athena_parameters: ?AthenaParameters,
    /// The parameters for Amazon Aurora MySQL.
    aurora_parameters: ?AuroraParameters,
    /// The parameters for Amazon Aurora.
    aurora_postgre_sql_parameters: ?AuroraPostgreSqlParameters,
    /// The parameters for IoT Analytics.
    aws_iot_analytics_parameters: ?AwsIotAnalyticsParameters,
    /// The parameters that are required to connect to a Google BigQuery data
    /// source.
    big_query_parameters: ?BigQueryParameters,
    /// The parameters for Confluence.
    confluence_parameters: ?ConfluenceParameters,
    /// The parameters for custom connectors.
    custom_connection_parameters: ?CustomConnectionParameters,
    /// The parameters that are required to connect to a Databricks data source.
    databricks_parameters: ?DatabricksParameters,
    /// The parameters for Exasol.
    exasol_parameters: ?ExasolParameters,
    /// The parameters for Impala.
    impala_parameters: ?ImpalaParameters,
    /// The parameters for Jira.
    jira_parameters: ?JiraParameters,
    /// The parameters for MariaDB.
    maria_db_parameters: ?MariaDbParameters,
    /// The parameters for MySQL.
    my_sql_parameters: ?MySqlParameters,
    /// The parameters for Oracle.
    oracle_parameters: ?OracleParameters,
    /// The parameters for PostgreSQL.
    postgre_sql_parameters: ?PostgreSqlParameters,
    /// The parameters for Presto.
    presto_parameters: ?PrestoParameters,
    /// The parameters for Amazon Q Business.
    q_business_parameters: ?QBusinessParameters,
    /// The parameters for Amazon RDS.
    rds_parameters: ?RdsParameters,
    /// The parameters for Amazon Redshift.
    redshift_parameters: ?RedshiftParameters,
    /// The parameters for S3 Knowledge Base.
    s3_knowledge_base_parameters: ?S3KnowledgeBaseParameters,
    /// The parameters for S3.
    s3_parameters: ?S3Parameters,
    /// The parameters for ServiceNow.
    service_now_parameters: ?ServiceNowParameters,
    /// The parameters for Snowflake.
    snowflake_parameters: ?SnowflakeParameters,
    /// The parameters for Spark.
    spark_parameters: ?SparkParameters,
    /// The parameters for SQL Server.
    sql_server_parameters: ?SqlServerParameters,
    /// The parameters that are required to connect to a Starburst data source.
    starburst_parameters: ?StarburstParameters,
    /// The parameters for Teradata.
    teradata_parameters: ?TeradataParameters,
    /// The parameters that are required to connect to a Trino data source.
    trino_parameters: ?TrinoParameters,
    /// The parameters for Twitter.
    twitter_parameters: ?TwitterParameters,
    /// The parameters for Web Crawler.
    web_crawler_parameters: ?WebCrawlerParameters,

    pub const json_field_names = .{
        .amazon_elasticsearch_parameters = "AmazonElasticsearchParameters",
        .amazon_open_search_parameters = "AmazonOpenSearchParameters",
        .athena_parameters = "AthenaParameters",
        .aurora_parameters = "AuroraParameters",
        .aurora_postgre_sql_parameters = "AuroraPostgreSqlParameters",
        .aws_iot_analytics_parameters = "AwsIotAnalyticsParameters",
        .big_query_parameters = "BigQueryParameters",
        .confluence_parameters = "ConfluenceParameters",
        .custom_connection_parameters = "CustomConnectionParameters",
        .databricks_parameters = "DatabricksParameters",
        .exasol_parameters = "ExasolParameters",
        .impala_parameters = "ImpalaParameters",
        .jira_parameters = "JiraParameters",
        .maria_db_parameters = "MariaDbParameters",
        .my_sql_parameters = "MySqlParameters",
        .oracle_parameters = "OracleParameters",
        .postgre_sql_parameters = "PostgreSqlParameters",
        .presto_parameters = "PrestoParameters",
        .q_business_parameters = "QBusinessParameters",
        .rds_parameters = "RdsParameters",
        .redshift_parameters = "RedshiftParameters",
        .s3_knowledge_base_parameters = "S3KnowledgeBaseParameters",
        .s3_parameters = "S3Parameters",
        .service_now_parameters = "ServiceNowParameters",
        .snowflake_parameters = "SnowflakeParameters",
        .spark_parameters = "SparkParameters",
        .sql_server_parameters = "SqlServerParameters",
        .starburst_parameters = "StarburstParameters",
        .teradata_parameters = "TeradataParameters",
        .trino_parameters = "TrinoParameters",
        .twitter_parameters = "TwitterParameters",
        .web_crawler_parameters = "WebCrawlerParameters",
    };
};
