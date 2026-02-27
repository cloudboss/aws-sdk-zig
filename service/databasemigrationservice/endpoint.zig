const DmsTransferSettings = @import("dms_transfer_settings.zig").DmsTransferSettings;
const DocDbSettings = @import("doc_db_settings.zig").DocDbSettings;
const DynamoDbSettings = @import("dynamo_db_settings.zig").DynamoDbSettings;
const ElasticsearchSettings = @import("elasticsearch_settings.zig").ElasticsearchSettings;
const ReplicationEndpointTypeValue = @import("replication_endpoint_type_value.zig").ReplicationEndpointTypeValue;
const GcpMySQLSettings = @import("gcp_my_sql_settings.zig").GcpMySQLSettings;
const IBMDb2Settings = @import("ibm_db_2_settings.zig").IBMDb2Settings;
const KafkaSettings = @import("kafka_settings.zig").KafkaSettings;
const KinesisSettings = @import("kinesis_settings.zig").KinesisSettings;
const LakehouseSettings = @import("lakehouse_settings.zig").LakehouseSettings;
const MicrosoftSQLServerSettings = @import("microsoft_sql_server_settings.zig").MicrosoftSQLServerSettings;
const MongoDbSettings = @import("mongo_db_settings.zig").MongoDbSettings;
const MySQLSettings = @import("my_sql_settings.zig").MySQLSettings;
const NeptuneSettings = @import("neptune_settings.zig").NeptuneSettings;
const OracleSettings = @import("oracle_settings.zig").OracleSettings;
const PostgreSQLSettings = @import("postgre_sql_settings.zig").PostgreSQLSettings;
const RedisSettings = @import("redis_settings.zig").RedisSettings;
const RedshiftSettings = @import("redshift_settings.zig").RedshiftSettings;
const S3Settings = @import("s3_settings.zig").S3Settings;
const DmsSslModeValue = @import("dms_ssl_mode_value.zig").DmsSslModeValue;
const SybaseSettings = @import("sybase_settings.zig").SybaseSettings;
const TimestreamSettings = @import("timestream_settings.zig").TimestreamSettings;

/// Describes an endpoint of a database instance in response to operations such
/// as the
/// following:
///
/// * `CreateEndpoint`
///
/// * `DescribeEndpoint`
///
/// * `ModifyEndpoint`
pub const Endpoint = struct {
    /// The Amazon Resource Name (ARN) used for SSL connection to the endpoint.
    certificate_arn: ?[]const u8,

    /// The name of the database at the endpoint.
    database_name: ?[]const u8,

    /// The settings for the DMS Transfer type source. For more information, see
    /// the DmsTransferSettings structure.
    dms_transfer_settings: ?DmsTransferSettings,

    doc_db_settings: ?DocDbSettings,

    /// The settings for the DynamoDB target endpoint. For more information, see the
    /// `DynamoDBSettings` structure.
    dynamo_db_settings: ?DynamoDbSettings,

    /// The settings for the OpenSearch source endpoint. For more information, see
    /// the `ElasticsearchSettings` structure.
    elasticsearch_settings: ?ElasticsearchSettings,

    /// The Amazon Resource Name (ARN) string that uniquely identifies the endpoint.
    endpoint_arn: ?[]const u8,

    /// The database endpoint identifier. Identifiers must begin with a letter and
    /// must contain
    /// only ASCII letters, digits, and hyphens. They can't end with a hyphen or
    /// contain two
    /// consecutive hyphens.
    endpoint_identifier: ?[]const u8,

    /// The type of endpoint. Valid values are `source` and
    /// `target`.
    endpoint_type: ?ReplicationEndpointTypeValue,

    /// The expanded name for the engine name. For example, if the `EngineName`
    /// parameter is "aurora", this value would be "Amazon Aurora MySQL".
    engine_display_name: ?[]const u8,

    /// The database engine name. Valid values, depending on the EndpointType,
    /// include
    /// `"mysql"`, `"oracle"`, `"postgres"`,
    /// `"mariadb"`, `"aurora"`, `"aurora-postgresql"`,
    /// `"redshift"`, `"redshift-serverless"`, `"s3"`,
    /// `"db2"`, `"db2-zos"`, `"azuredb"`,
    /// `"sybase"`, `"dynamodb"`, `"mongodb"`,
    /// `"kinesis"`, `"kafka"`, `"elasticsearch"`,
    /// `"documentdb"`, `"sqlserver"`, `"neptune"`, and
    /// `"babelfish"`.
    engine_name: ?[]const u8,

    /// Value returned by a call to CreateEndpoint that can be used for
    /// cross-account
    /// validation. Use it on a subsequent call to CreateEndpoint to create the
    /// endpoint with a
    /// cross-account.
    external_id: ?[]const u8,

    /// The external table definition.
    external_table_definition: ?[]const u8,

    /// Additional connection attributes used to connect to the endpoint.
    extra_connection_attributes: ?[]const u8,

    /// Settings in JSON format for the source GCP MySQL endpoint.
    gcp_my_sql_settings: ?GcpMySQLSettings,

    /// The settings for the IBM Db2 LUW source endpoint. For more information, see
    /// the
    /// `IBMDb2Settings` structure.
    ibm_db_2_settings: ?IBMDb2Settings,

    /// Indicates whether the endpoint is read-only. When set to `true`, this
    /// endpoint
    /// is managed by DMS as part of a zero-ETL integration and cannot be modified
    /// or deleted directly.
    /// You can only modify or delete read-only endpoints through their associated
    /// zero-ETL integration.
    is_read_only: ?bool,

    /// The settings for the Apache Kafka target endpoint. For more information, see
    /// the
    /// `KafkaSettings` structure.
    kafka_settings: ?KafkaSettings,

    /// The settings for the Amazon Kinesis target endpoint. For more information,
    /// see the
    /// `KinesisSettings` structure.
    kinesis_settings: ?KinesisSettings,

    /// An KMS key identifier that is used to encrypt the connection parameters for
    /// the
    /// endpoint.
    ///
    /// If you don't specify a value for the `KmsKeyId` parameter, then DMS uses
    /// your default encryption key.
    ///
    /// KMS creates the default encryption key for your Amazon Web Services account.
    /// Your Amazon Web Services account has
    /// a different default encryption key for each Amazon Web Services Region.
    kms_key_id: ?[]const u8,

    /// Settings in JSON format for the target Lakehouse endpoint. This parameter
    /// applies to endpoints
    /// that are automatically created by DMS for a Lakehouse data warehouse as part
    /// of a zero-ETL integration.
    lakehouse_settings: ?LakehouseSettings,

    /// The settings for the Microsoft SQL Server source and target endpoint. For
    /// more
    /// information, see the `MicrosoftSQLServerSettings` structure.
    microsoft_sql_server_settings: ?MicrosoftSQLServerSettings,

    /// The settings for the MongoDB source endpoint. For more information, see the
    /// `MongoDbSettings` structure.
    mongo_db_settings: ?MongoDbSettings,

    /// The settings for the MySQL source and target endpoint. For more information,
    /// see the
    /// `MySQLSettings` structure.
    my_sql_settings: ?MySQLSettings,

    /// The settings for the Amazon Neptune target endpoint. For more information,
    /// see the
    /// `NeptuneSettings` structure.
    neptune_settings: ?NeptuneSettings,

    /// The settings for the Oracle source and target endpoint. For more
    /// information, see the
    /// `OracleSettings` structure.
    oracle_settings: ?OracleSettings,

    /// The port value used to access the endpoint.
    port: ?i32,

    /// The settings for the PostgreSQL source and target endpoint. For more
    /// information, see
    /// the `PostgreSQLSettings` structure.
    postgre_sql_settings: ?PostgreSQLSettings,

    /// The settings for the Redis target endpoint. For more information, see the
    /// `RedisSettings` structure.
    redis_settings: ?RedisSettings,

    /// Settings for the Amazon Redshift endpoint.
    redshift_settings: ?RedshiftSettings,

    /// The settings for the S3 target endpoint. For more information, see the
    /// `S3Settings` structure.
    s3_settings: ?S3Settings,

    /// The name of the server at the endpoint.
    server_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) used by the service to access the IAM role.
    /// The role must
    /// allow the `iam:PassRole` action.
    service_access_role_arn: ?[]const u8,

    /// The SSL mode used to connect to the endpoint. The default value is
    /// `none`.
    ssl_mode: ?DmsSslModeValue,

    /// The status of the endpoint.
    status: ?[]const u8,

    /// The settings for the SAP ASE source and target endpoint. For more
    /// information, see the
    /// `SybaseSettings` structure.
    sybase_settings: ?SybaseSettings,

    /// The settings for the Amazon Timestream target endpoint. For more
    /// information, see the
    /// `TimestreamSettings` structure.
    timestream_settings: ?TimestreamSettings,

    /// The user name used to connect to the endpoint.
    username: ?[]const u8,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .database_name = "DatabaseName",
        .dms_transfer_settings = "DmsTransferSettings",
        .doc_db_settings = "DocDbSettings",
        .dynamo_db_settings = "DynamoDbSettings",
        .elasticsearch_settings = "ElasticsearchSettings",
        .endpoint_arn = "EndpointArn",
        .endpoint_identifier = "EndpointIdentifier",
        .endpoint_type = "EndpointType",
        .engine_display_name = "EngineDisplayName",
        .engine_name = "EngineName",
        .external_id = "ExternalId",
        .external_table_definition = "ExternalTableDefinition",
        .extra_connection_attributes = "ExtraConnectionAttributes",
        .gcp_my_sql_settings = "GcpMySQLSettings",
        .ibm_db_2_settings = "IBMDb2Settings",
        .is_read_only = "IsReadOnly",
        .kafka_settings = "KafkaSettings",
        .kinesis_settings = "KinesisSettings",
        .kms_key_id = "KmsKeyId",
        .lakehouse_settings = "LakehouseSettings",
        .microsoft_sql_server_settings = "MicrosoftSQLServerSettings",
        .mongo_db_settings = "MongoDbSettings",
        .my_sql_settings = "MySQLSettings",
        .neptune_settings = "NeptuneSettings",
        .oracle_settings = "OracleSettings",
        .port = "Port",
        .postgre_sql_settings = "PostgreSQLSettings",
        .redis_settings = "RedisSettings",
        .redshift_settings = "RedshiftSettings",
        .s3_settings = "S3Settings",
        .server_name = "ServerName",
        .service_access_role_arn = "ServiceAccessRoleArn",
        .ssl_mode = "SslMode",
        .status = "Status",
        .sybase_settings = "SybaseSettings",
        .timestream_settings = "TimestreamSettings",
        .username = "Username",
    };
};
