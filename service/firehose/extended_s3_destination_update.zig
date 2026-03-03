const BufferingHints = @import("buffering_hints.zig").BufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const CompressionFormat = @import("compression_format.zig").CompressionFormat;
const DataFormatConversionConfiguration = @import("data_format_conversion_configuration.zig").DataFormatConversionConfiguration;
const DynamicPartitioningConfiguration = @import("dynamic_partitioning_configuration.zig").DynamicPartitioningConfiguration;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const S3BackupMode = @import("s3_backup_mode.zig").S3BackupMode;
const S3DestinationUpdate = @import("s3_destination_update.zig").S3DestinationUpdate;

/// Describes an update for a destination in Amazon S3.
pub const ExtendedS3DestinationUpdate = struct {
    /// The ARN of the S3 bucket. For more information, see [Amazon Resource Names
    /// (ARNs) and
    /// Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    bucket_arn: ?[]const u8 = null,

    /// The buffering option.
    buffering_hints: ?BufferingHints = null,

    /// The Amazon CloudWatch logging options for your Firehose stream.
    cloud_watch_logging_options: ?CloudWatchLoggingOptions = null,

    /// The compression format. If no value is specified, the default is
    /// `UNCOMPRESSED`.
    compression_format: ?CompressionFormat = null,

    /// The time zone you prefer. UTC is the default.
    custom_time_zone: ?[]const u8 = null,

    /// The serializer, deserializer, and schema for converting data from the JSON
    /// format to
    /// the Parquet or ORC format before writing it to Amazon S3.
    data_format_conversion_configuration: ?DataFormatConversionConfiguration = null,

    /// The configuration of the dynamic partitioning mechanism that creates smaller
    /// data sets
    /// from the streaming data by partitioning it based on partition keys.
    /// Currently, dynamic
    /// partitioning is only supported for Amazon S3 destinations.
    dynamic_partitioning_configuration: ?DynamicPartitioningConfiguration = null,

    /// The encryption configuration. If no value is specified, the default is no
    /// encryption.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// A prefix that Firehose evaluates and adds to failed records before writing
    /// them to S3. This prefix appears immediately following the bucket name. For
    /// information
    /// about how to specify this prefix, see [Custom Prefixes for Amazon S3
    /// Objects](https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html).
    error_output_prefix: ?[]const u8 = null,

    /// Specify a file extension. It will override the default file extension
    file_extension: ?[]const u8 = null,

    /// The "YYYY/MM/DD/HH" time format prefix is automatically used for delivered
    /// Amazon S3
    /// files. You can also specify a custom prefix, as described in [Custom
    /// Prefixes for Amazon S3
    /// Objects](https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html).
    prefix: ?[]const u8 = null,

    /// The data processing configuration.
    processing_configuration: ?ProcessingConfiguration = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services credentials. For
    /// more
    /// information, see [Amazon Resource Names (ARNs) and
    /// Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    role_arn: ?[]const u8 = null,

    /// You can update a Firehose stream to enable Amazon S3 backup if it is
    /// disabled. If
    /// backup is enabled, you can't update the Firehose stream to disable it.
    s3_backup_mode: ?S3BackupMode = null,

    /// The Amazon S3 destination for backup.
    s3_backup_update: ?S3DestinationUpdate = null,

    pub const json_field_names = .{
        .bucket_arn = "BucketARN",
        .buffering_hints = "BufferingHints",
        .cloud_watch_logging_options = "CloudWatchLoggingOptions",
        .compression_format = "CompressionFormat",
        .custom_time_zone = "CustomTimeZone",
        .data_format_conversion_configuration = "DataFormatConversionConfiguration",
        .dynamic_partitioning_configuration = "DynamicPartitioningConfiguration",
        .encryption_configuration = "EncryptionConfiguration",
        .error_output_prefix = "ErrorOutputPrefix",
        .file_extension = "FileExtension",
        .prefix = "Prefix",
        .processing_configuration = "ProcessingConfiguration",
        .role_arn = "RoleARN",
        .s3_backup_mode = "S3BackupMode",
        .s3_backup_update = "S3BackupUpdate",
    };
};
