const AmazonOpenSearchServerlessBufferingHints = @import("amazon_open_search_serverless_buffering_hints.zig").AmazonOpenSearchServerlessBufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const AmazonOpenSearchServerlessRetryOptions = @import("amazon_open_search_serverless_retry_options.zig").AmazonOpenSearchServerlessRetryOptions;
const AmazonOpenSearchServerlessS3BackupMode = @import("amazon_open_search_serverless_s3_backup_mode.zig").AmazonOpenSearchServerlessS3BackupMode;
const S3DestinationConfiguration = @import("s3_destination_configuration.zig").S3DestinationConfiguration;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;

/// Describes the configuration of a destination in the Serverless offering for
/// Amazon
/// OpenSearch Service.
pub const AmazonOpenSearchServerlessDestinationConfiguration = struct {
    /// The buffering options. If no value is specified, the default values for
    /// AmazonopensearchserviceBufferingHints are used.
    buffering_hints: ?AmazonOpenSearchServerlessBufferingHints = null,

    cloud_watch_logging_options: ?CloudWatchLoggingOptions = null,

    /// The endpoint to use when communicating with the collection in the Serverless
    /// offering
    /// for Amazon OpenSearch Service.
    collection_endpoint: ?[]const u8 = null,

    /// The Serverless offering for Amazon OpenSearch Service index name.
    index_name: []const u8,

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
    role_arn: []const u8,

    /// Defines how documents should be delivered to Amazon S3. When it is set to
    /// FailedDocumentsOnly, Firehose writes any documents that could not be indexed
    /// to the configured Amazon S3 destination, with
    /// AmazonOpenSearchService-failed/ appended to
    /// the key prefix. When set to AllDocuments, Firehose delivers all incoming
    /// records to Amazon S3, and also writes failed documents with
    /// AmazonOpenSearchService-failed/
    /// appended to the prefix.
    s3_backup_mode: ?AmazonOpenSearchServerlessS3BackupMode = null,

    s3_configuration: S3DestinationConfiguration,

    vpc_configuration: ?VpcConfiguration = null,

    pub const json_field_names = .{
        .buffering_hints = "BufferingHints",
        .cloud_watch_logging_options = "CloudWatchLoggingOptions",
        .collection_endpoint = "CollectionEndpoint",
        .index_name = "IndexName",
        .processing_configuration = "ProcessingConfiguration",
        .retry_options = "RetryOptions",
        .role_arn = "RoleARN",
        .s3_backup_mode = "S3BackupMode",
        .s3_configuration = "S3Configuration",
        .vpc_configuration = "VpcConfiguration",
    };
};
