const SnowflakeBufferingHints = @import("snowflake_buffering_hints.zig").SnowflakeBufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const SnowflakeDataLoadingOption = @import("snowflake_data_loading_option.zig").SnowflakeDataLoadingOption;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const SnowflakeRetryOptions = @import("snowflake_retry_options.zig").SnowflakeRetryOptions;
const SnowflakeS3BackupMode = @import("snowflake_s3_backup_mode.zig").SnowflakeS3BackupMode;
const S3DestinationConfiguration = @import("s3_destination_configuration.zig").S3DestinationConfiguration;
const SecretsManagerConfiguration = @import("secrets_manager_configuration.zig").SecretsManagerConfiguration;
const SnowflakeRoleConfiguration = @import("snowflake_role_configuration.zig").SnowflakeRoleConfiguration;
const SnowflakeVpcConfiguration = @import("snowflake_vpc_configuration.zig").SnowflakeVpcConfiguration;

/// Configure Snowflake destination
pub const SnowflakeDestinationConfiguration = struct {
    /// URL for accessing your Snowflake account. This URL must include your
    /// [account
    /// identifier](https://docs.snowflake.com/en/user-guide/admin-account-identifier).
    /// Note that the protocol (https://) and port number are optional.
    account_url: []const u8,

    /// Describes the buffering to perform before delivering data to the Snowflake
    /// destination. If you do not specify any value, Firehose uses the default
    /// values.
    buffering_hints: ?SnowflakeBufferingHints = null,

    cloud_watch_logging_options: ?CloudWatchLoggingOptions = null,

    /// The name of the record content column.
    content_column_name: ?[]const u8 = null,

    /// All data in Snowflake is maintained in databases.
    database: []const u8,

    /// Choose to load JSON keys mapped to table column names or choose to split the
    /// JSON payload where content is mapped to a record content column and source
    /// metadata is mapped to a record metadata column.
    data_loading_option: ?SnowflakeDataLoadingOption = null,

    /// Passphrase to decrypt the private key when the key is encrypted. For
    /// information, see [Using Key Pair Authentication & Key
    /// Rotation](https://docs.snowflake.com/en/user-guide/data-load-snowpipe-streaming-configuration#using-key-pair-authentication-key-rotation).
    key_passphrase: ?[]const u8 = null,

    /// Specify a column name in the table, where the metadata information has to be
    /// loaded.
    /// When you enable this field, you will see the following column in the
    /// snowflake table, which
    /// differs based on the source type.
    ///
    /// For Direct PUT as source
    ///
    /// `{ "firehoseDeliveryStreamName" : "streamname", "IngestionTime" :
    /// "timestamp"
    /// }`
    ///
    /// For Kinesis Data Stream as source
    ///
    /// ` "kinesisStreamName" : "streamname", "kinesisShardId" : "Id",
    /// "kinesisPartitionKey" : "key", "kinesisSequenceNumber" : "1234",
    /// "subsequenceNumber" :
    /// "2334", "IngestionTime" : "timestamp" }`
    meta_data_column_name: ?[]const u8 = null,

    /// The private key used to encrypt your Snowflake client. For information, see
    /// [Using Key Pair Authentication & Key
    /// Rotation](https://docs.snowflake.com/en/user-guide/data-load-snowpipe-streaming-configuration#using-key-pair-authentication-key-rotation).
    private_key: ?[]const u8 = null,

    processing_configuration: ?ProcessingConfiguration = null,

    /// The time period where Firehose will retry sending data to the chosen HTTP
    /// endpoint.
    retry_options: ?SnowflakeRetryOptions = null,

    /// The Amazon Resource Name (ARN) of the Snowflake role
    role_arn: []const u8,

    /// Choose an S3 backup mode
    s3_backup_mode: ?SnowflakeS3BackupMode = null,

    s3_configuration: S3DestinationConfiguration,

    /// Each database consists of one or more schemas, which are logical groupings
    /// of database objects, such as tables and views
    schema: []const u8,

    /// The configuration that defines how you access secrets for Snowflake.
    secrets_manager_configuration: ?SecretsManagerConfiguration = null,

    /// Optionally configure a Snowflake role. Otherwise the default user role will
    /// be used.
    snowflake_role_configuration: ?SnowflakeRoleConfiguration = null,

    /// The VPCE ID for Firehose to privately connect with Snowflake. The ID format
    /// is
    /// com.amazonaws.vpce.[region].vpce-svc-. For more information, see [Amazon
    /// PrivateLink &
    /// Snowflake](https://docs.snowflake.com/en/user-guide/admin-security-privatelink)
    snowflake_vpc_configuration: ?SnowflakeVpcConfiguration = null,

    /// All data in Snowflake is stored in database tables, logically structured as
    /// collections of columns and rows.
    table: []const u8,

    /// User login name for the Snowflake account.
    user: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_url = "AccountUrl",
        .buffering_hints = "BufferingHints",
        .cloud_watch_logging_options = "CloudWatchLoggingOptions",
        .content_column_name = "ContentColumnName",
        .database = "Database",
        .data_loading_option = "DataLoadingOption",
        .key_passphrase = "KeyPassphrase",
        .meta_data_column_name = "MetaDataColumnName",
        .private_key = "PrivateKey",
        .processing_configuration = "ProcessingConfiguration",
        .retry_options = "RetryOptions",
        .role_arn = "RoleARN",
        .s3_backup_mode = "S3BackupMode",
        .s3_configuration = "S3Configuration",
        .schema = "Schema",
        .secrets_manager_configuration = "SecretsManagerConfiguration",
        .snowflake_role_configuration = "SnowflakeRoleConfiguration",
        .snowflake_vpc_configuration = "SnowflakeVpcConfiguration",
        .table = "Table",
        .user = "User",
    };
};
