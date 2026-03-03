const AmazonOpenSearchServerlessBufferingHints = @import("amazon_open_search_serverless_buffering_hints.zig").AmazonOpenSearchServerlessBufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const AmazonOpenSearchServerlessRetryOptions = @import("amazon_open_search_serverless_retry_options.zig").AmazonOpenSearchServerlessRetryOptions;
const S3DestinationUpdate = @import("s3_destination_update.zig").S3DestinationUpdate;

/// Describes an update for a destination in the Serverless offering for Amazon
/// OpenSearch
/// Service.
pub const AmazonOpenSearchServerlessDestinationUpdate = struct {
    /// The buffering options. If no value is specified,
    /// AmazonopensearchBufferingHints object
    /// default values are used.
    buffering_hints: ?AmazonOpenSearchServerlessBufferingHints = null,

    cloud_watch_logging_options: ?CloudWatchLoggingOptions = null,

    /// The endpoint to use when communicating with the collection in the Serverless
    /// offering
    /// for Amazon OpenSearch Service.
    collection_endpoint: ?[]const u8 = null,

    /// The Serverless offering for Amazon OpenSearch Service index name.
    index_name: ?[]const u8 = null,

    processing_configuration: ?ProcessingConfiguration = null,

    /// The retry behavior in case Firehose is unable to deliver documents to the
    /// Serverless offering for Amazon OpenSearch Service. The default value is 300
    /// (5
    /// minutes).
    retry_options: ?AmazonOpenSearchServerlessRetryOptions = null,

    /// The Amazon Resource Name (ARN) of the IAM role to be assumed by Firehose
    /// for calling the Serverless offering for Amazon OpenSearch Service
    /// Configuration API and for
    /// indexing documents.
    role_arn: ?[]const u8 = null,

    s3_update: ?S3DestinationUpdate = null,

    pub const json_field_names = .{
        .buffering_hints = "BufferingHints",
        .cloud_watch_logging_options = "CloudWatchLoggingOptions",
        .collection_endpoint = "CollectionEndpoint",
        .index_name = "IndexName",
        .processing_configuration = "ProcessingConfiguration",
        .retry_options = "RetryOptions",
        .role_arn = "RoleARN",
        .s3_update = "S3Update",
    };
};
