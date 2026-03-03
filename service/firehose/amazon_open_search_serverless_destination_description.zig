const AmazonOpenSearchServerlessBufferingHints = @import("amazon_open_search_serverless_buffering_hints.zig").AmazonOpenSearchServerlessBufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const AmazonOpenSearchServerlessRetryOptions = @import("amazon_open_search_serverless_retry_options.zig").AmazonOpenSearchServerlessRetryOptions;
const AmazonOpenSearchServerlessS3BackupMode = @import("amazon_open_search_serverless_s3_backup_mode.zig").AmazonOpenSearchServerlessS3BackupMode;
const S3DestinationDescription = @import("s3_destination_description.zig").S3DestinationDescription;
const VpcConfigurationDescription = @import("vpc_configuration_description.zig").VpcConfigurationDescription;

/// The destination description in the Serverless offering for Amazon OpenSearch
/// Service.
pub const AmazonOpenSearchServerlessDestinationDescription = struct {
    /// The buffering options.
    buffering_hints: ?AmazonOpenSearchServerlessBufferingHints = null,

    cloud_watch_logging_options: ?CloudWatchLoggingOptions = null,

    /// The endpoint to use when communicating with the collection in the Serverless
    /// offering
    /// for Amazon OpenSearch Service.
    collection_endpoint: ?[]const u8 = null,

    /// The Serverless offering for Amazon OpenSearch Service index name.
    index_name: ?[]const u8 = null,

    processing_configuration: ?ProcessingConfiguration = null,

    /// The Serverless offering for Amazon OpenSearch Service retry options.
    retry_options: ?AmazonOpenSearchServerlessRetryOptions = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services credentials.
    role_arn: ?[]const u8 = null,

    /// The Amazon S3 backup mode.
    s3_backup_mode: ?AmazonOpenSearchServerlessS3BackupMode = null,

    s3_destination_description: ?S3DestinationDescription = null,

    vpc_configuration_description: ?VpcConfigurationDescription = null,

    pub const json_field_names = .{
        .buffering_hints = "BufferingHints",
        .cloud_watch_logging_options = "CloudWatchLoggingOptions",
        .collection_endpoint = "CollectionEndpoint",
        .index_name = "IndexName",
        .processing_configuration = "ProcessingConfiguration",
        .retry_options = "RetryOptions",
        .role_arn = "RoleARN",
        .s3_backup_mode = "S3BackupMode",
        .s3_destination_description = "S3DestinationDescription",
        .vpc_configuration_description = "VpcConfigurationDescription",
    };
};
