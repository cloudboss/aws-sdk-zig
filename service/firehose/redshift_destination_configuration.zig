const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const CopyCommand = @import("copy_command.zig").CopyCommand;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const RedshiftRetryOptions = @import("redshift_retry_options.zig").RedshiftRetryOptions;
const S3DestinationConfiguration = @import("s3_destination_configuration.zig").S3DestinationConfiguration;
const RedshiftS3BackupMode = @import("redshift_s3_backup_mode.zig").RedshiftS3BackupMode;
const SecretsManagerConfiguration = @import("secrets_manager_configuration.zig").SecretsManagerConfiguration;

/// Describes the configuration of a destination in Amazon Redshift.
pub const RedshiftDestinationConfiguration = struct {
    /// The CloudWatch logging options for your Firehose stream.
    cloud_watch_logging_options: ?CloudWatchLoggingOptions,

    /// The database connection string.
    cluster_jdbcurl: []const u8,

    /// The `COPY` command.
    copy_command: CopyCommand,

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
    role_arn: []const u8,

    /// The configuration for backup in Amazon S3.
    s3_backup_configuration: ?S3DestinationConfiguration,

    /// The Amazon S3 backup mode. After you create a Firehose stream, you can
    /// update it to
    /// enable Amazon S3 backup if it is disabled. If backup is enabled, you can't
    /// update the
    /// Firehose stream to disable it.
    s3_backup_mode: ?RedshiftS3BackupMode,

    /// The configuration for the intermediate Amazon S3 location from which Amazon
    /// Redshift
    /// obtains data. Restrictions are described in the topic for
    /// CreateDeliveryStream.
    ///
    /// The compression formats `SNAPPY` or `ZIP` cannot be specified
    /// in `RedshiftDestinationConfiguration.S3Configuration` because the Amazon
    /// Redshift `COPY` operation that reads from the S3 bucket doesn't support
    /// these
    /// compression formats.
    s3_configuration: S3DestinationConfiguration,

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
        .s3_backup_configuration = "S3BackupConfiguration",
        .s3_backup_mode = "S3BackupMode",
        .s3_configuration = "S3Configuration",
        .secrets_manager_configuration = "SecretsManagerConfiguration",
        .username = "Username",
    };
};
