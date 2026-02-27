const SnowflakeBufferingHints = @import("snowflake_buffering_hints.zig").SnowflakeBufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const SnowflakeDataLoadingOption = @import("snowflake_data_loading_option.zig").SnowflakeDataLoadingOption;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const SnowflakeRetryOptions = @import("snowflake_retry_options.zig").SnowflakeRetryOptions;
const SnowflakeS3BackupMode = @import("snowflake_s3_backup_mode.zig").SnowflakeS3BackupMode;
const S3DestinationUpdate = @import("s3_destination_update.zig").S3DestinationUpdate;
const SecretsManagerConfiguration = @import("secrets_manager_configuration.zig").SecretsManagerConfiguration;
const SnowflakeRoleConfiguration = @import("snowflake_role_configuration.zig").SnowflakeRoleConfiguration;

/// Update to configuration settings
pub const SnowflakeDestinationUpdate = struct {
    /// URL for accessing your Snowflake account. This URL must include your
    /// [account
    /// identifier](https://docs.snowflake.com/en/user-guide/admin-account-identifier).
    /// Note that the protocol (https://) and port number are optional.
    account_url: ?[]const u8,

    /// Describes the buffering to perform before delivering data to the Snowflake
    /// destination.
    buffering_hints: ?SnowflakeBufferingHints,

    cloud_watch_logging_options: ?CloudWatchLoggingOptions,

    /// The name of the content metadata column
    content_column_name: ?[]const u8,

    /// All data in Snowflake is maintained in databases.
    database: ?[]const u8,

    /// JSON keys mapped to table column names or choose to split the JSON payload
    /// where content is mapped to a record content column and source metadata is
    /// mapped to a record metadata column.
    data_loading_option: ?SnowflakeDataLoadingOption,

    /// Passphrase to decrypt the private key when the key is encrypted. For
    /// information, see [Using Key Pair Authentication & Key
    /// Rotation](https://docs.snowflake.com/en/user-guide/data-load-snowpipe-streaming-configuration#using-key-pair-authentication-key-rotation).
    key_passphrase: ?[]const u8,

    /// The name of the record metadata column
    meta_data_column_name: ?[]const u8,

    /// The private key used to encrypt your Snowflake client. For information, see
    /// [Using Key Pair Authentication & Key
    /// Rotation](https://docs.snowflake.com/en/user-guide/data-load-snowpipe-streaming-configuration#using-key-pair-authentication-key-rotation).
    private_key: ?[]const u8,

    processing_configuration: ?ProcessingConfiguration,

    /// Specify how long Firehose retries sending data to the New Relic HTTP
    /// endpoint.
    ///
    /// After sending data, Firehose first waits for an acknowledgment from the HTTP
    /// endpoint. If an error occurs or the acknowledgment doesn’t arrive within the
    /// acknowledgment timeout period, Firehose starts the retry duration counter.
    /// It keeps retrying until the retry duration expires. After that, Firehose
    /// considers it a data delivery failure and backs up the data to your Amazon S3
    /// bucket.
    ///
    /// Every time that Firehose sends data to the HTTP endpoint (either the initial
    /// attempt or a retry), it restarts the acknowledgement timeout counter and
    /// waits for an acknowledgement from the HTTP endpoint.
    ///
    /// Even if the retry duration expires, Firehose still waits for the
    /// acknowledgment until it receives it or the acknowledgement timeout period is
    /// reached. If the acknowledgment times out, Firehose determines whether
    /// there's time left in the retry counter. If there is time left, it retries
    /// again and repeats the logic until it receives an acknowledgment or
    /// determines that the retry time has expired.
    ///
    /// If you don't want Firehose to retry sending data, set this value to 0.
    retry_options: ?SnowflakeRetryOptions,

    /// The Amazon Resource Name (ARN) of the Snowflake role
    role_arn: ?[]const u8,

    /// Choose an S3 backup mode. Once you set the mode as `AllData`, you can not
    /// change it to `FailedDataOnly`.
    s3_backup_mode: ?SnowflakeS3BackupMode,

    s3_update: ?S3DestinationUpdate,

    /// Each database consists of one or more schemas, which are logical groupings
    /// of database objects, such as tables and views
    schema: ?[]const u8,

    /// Describes the Secrets Manager configuration in Snowflake.
    secrets_manager_configuration: ?SecretsManagerConfiguration,

    /// Optionally configure a Snowflake role. Otherwise the default user role will
    /// be used.
    snowflake_role_configuration: ?SnowflakeRoleConfiguration,

    /// All data in Snowflake is stored in database tables, logically structured as
    /// collections of columns and rows.
    table: ?[]const u8,

    /// User login name for the Snowflake account.
    user: ?[]const u8,

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
        .s3_update = "S3Update",
        .schema = "Schema",
        .secrets_manager_configuration = "SecretsManagerConfiguration",
        .snowflake_role_configuration = "SnowflakeRoleConfiguration",
        .table = "Table",
        .user = "User",
    };
};
