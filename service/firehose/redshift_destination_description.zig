const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const CopyCommand = @import("copy_command.zig").CopyCommand;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const RedshiftRetryOptions = @import("redshift_retry_options.zig").RedshiftRetryOptions;
const S3DestinationDescription = @import("s3_destination_description.zig").S3DestinationDescription;
const RedshiftS3BackupMode = @import("redshift_s3_backup_mode.zig").RedshiftS3BackupMode;
const SecretsManagerConfiguration = @import("secrets_manager_configuration.zig").SecretsManagerConfiguration;

/// Describes a destination in Amazon Redshift.
pub const RedshiftDestinationDescription = struct {
    /// The Amazon CloudWatch logging options for your Firehose stream.
    cloud_watch_logging_options: ?CloudWatchLoggingOptions = null,

    /// The database connection string.
    cluster_jdbcurl: []const u8,

    /// The `COPY` command.
    copy_command: CopyCommand,

    /// The data processing configuration.
    processing_configuration: ?ProcessingConfiguration = null,

    /// The retry behavior in case Firehose is unable to deliver documents to
    /// Amazon Redshift. Default value is 3600 (60 minutes).
    retry_options: ?RedshiftRetryOptions = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services credentials. For
    /// more
    /// information, see [Amazon Resource Names (ARNs) and
    /// Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    role_arn: []const u8,

    /// The configuration for backup in Amazon S3.
    s3_backup_description: ?S3DestinationDescription = null,

    /// The Amazon S3 backup mode.
    s3_backup_mode: ?RedshiftS3BackupMode = null,

    /// The Amazon S3 destination.
    s3_destination_description: S3DestinationDescription,

    /// The configuration that defines how you access secrets for Amazon Redshift.
    secrets_manager_configuration: ?SecretsManagerConfiguration = null,

    /// The name of the user.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_logging_options = "CloudWatchLoggingOptions",
        .cluster_jdbcurl = "ClusterJDBCURL",
        .copy_command = "CopyCommand",
        .processing_configuration = "ProcessingConfiguration",
        .retry_options = "RetryOptions",
        .role_arn = "RoleARN",
        .s3_backup_description = "S3BackupDescription",
        .s3_backup_mode = "S3BackupMode",
        .s3_destination_description = "S3DestinationDescription",
        .secrets_manager_configuration = "SecretsManagerConfiguration",
        .username = "Username",
    };
};
