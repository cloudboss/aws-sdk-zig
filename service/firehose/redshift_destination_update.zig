const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const CopyCommand = @import("copy_command.zig").CopyCommand;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const RedshiftRetryOptions = @import("redshift_retry_options.zig").RedshiftRetryOptions;
const RedshiftS3BackupMode = @import("redshift_s3_backup_mode.zig").RedshiftS3BackupMode;
const S3DestinationUpdate = @import("s3_destination_update.zig").S3DestinationUpdate;
const SecretsManagerConfiguration = @import("secrets_manager_configuration.zig").SecretsManagerConfiguration;

/// Describes an update for a destination in Amazon Redshift.
pub const RedshiftDestinationUpdate = struct {
    /// The Amazon CloudWatch logging options for your Firehose stream.
    cloud_watch_logging_options: ?CloudWatchLoggingOptions,

    /// The database connection string.
    cluster_jdbcurl: ?[]const u8,

    /// The `COPY` command.
    copy_command: ?CopyCommand,

    /// The user password.
    password: ?[]const u8,

    /// The data processing configuration.
    processing_configuration: ?ProcessingConfiguration,

    /// The retry behavior in case Firehose is unable to deliver documents to
    /// Amazon Redshift. Default value is 3600 (60 minutes).
    retry_options: ?RedshiftRetryOptions,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services credentials. For
    /// more
    /// information, see [Amazon Resource Names (ARNs) and
    /// Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    role_arn: ?[]const u8,

    /// You can update a Firehose stream to enable Amazon S3 backup if it is
    /// disabled. If
    /// backup is enabled, you can't update the Firehose stream to disable it.
    s3_backup_mode: ?RedshiftS3BackupMode,

    /// The Amazon S3 destination for backup.
    s3_backup_update: ?S3DestinationUpdate,

    /// The Amazon S3 destination.
    ///
    /// The compression formats `SNAPPY` or `ZIP` cannot be specified
    /// in `RedshiftDestinationUpdate.S3Update` because the Amazon Redshift
    /// `COPY` operation that reads from the S3 bucket doesn't support these
    /// compression formats.
    s3_update: ?S3DestinationUpdate,

    /// The configuration that defines how you access secrets for Amazon Redshift.
    secrets_manager_configuration: ?SecretsManagerConfiguration,

    /// The name of the user.
    username: ?[]const u8,

    pub const json_field_names = .{
        .cloud_watch_logging_options = "CloudWatchLoggingOptions",
        .cluster_jdbcurl = "ClusterJDBCURL",
        .copy_command = "CopyCommand",
        .password = "Password",
        .processing_configuration = "ProcessingConfiguration",
        .retry_options = "RetryOptions",
        .role_arn = "RoleARN",
        .s3_backup_mode = "S3BackupMode",
        .s3_backup_update = "S3BackupUpdate",
        .s3_update = "S3Update",
        .secrets_manager_configuration = "SecretsManagerConfiguration",
        .username = "Username",
    };
};
