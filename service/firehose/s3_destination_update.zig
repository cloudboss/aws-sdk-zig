const BufferingHints = @import("buffering_hints.zig").BufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const CompressionFormat = @import("compression_format.zig").CompressionFormat;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;

/// Describes an update for a destination in Amazon S3.
pub const S3DestinationUpdate = struct {
    /// The ARN of the S3 bucket. For more information, see [Amazon Resource Names
    /// (ARNs) and
    /// Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    bucket_arn: ?[]const u8 = null,

    /// The buffering option. If no value is specified, `BufferingHints` object
    /// default values are used.
    buffering_hints: ?BufferingHints = null,

    /// The CloudWatch logging options for your Firehose stream.
    cloud_watch_logging_options: ?CloudWatchLoggingOptions = null,

    /// The compression format. If no value is specified, the default is
    /// `UNCOMPRESSED`.
    ///
    /// The compression formats `SNAPPY` or `ZIP` cannot be specified
    /// for Amazon Redshift destinations because they are not supported by the
    /// Amazon Redshift
    /// `COPY` operation that reads from the S3 bucket.
    compression_format: ?CompressionFormat = null,

    /// The encryption configuration. If no value is specified, the default is no
    /// encryption.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// A prefix that Firehose evaluates and adds to failed records before writing
    /// them to S3. This prefix appears immediately following the bucket name. For
    /// information
    /// about how to specify this prefix, see [Custom Prefixes for Amazon S3
    /// Objects](https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html).
    error_output_prefix: ?[]const u8 = null,

    /// The "YYYY/MM/DD/HH" time format prefix is automatically used for delivered
    /// Amazon S3
    /// files. You can also specify a custom prefix, as described in [Custom
    /// Prefixes for Amazon S3
    /// Objects](https://docs.aws.amazon.com/firehose/latest/dev/s3-prefixes.html).
    prefix: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services credentials. For
    /// more
    /// information, see [Amazon Resource Names (ARNs) and
    /// Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket_arn = "BucketARN",
        .buffering_hints = "BufferingHints",
        .cloud_watch_logging_options = "CloudWatchLoggingOptions",
        .compression_format = "CompressionFormat",
        .encryption_configuration = "EncryptionConfiguration",
        .error_output_prefix = "ErrorOutputPrefix",
        .prefix = "Prefix",
        .role_arn = "RoleARN",
    };
};
