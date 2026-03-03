const AmazonopensearchserviceBufferingHints = @import("amazonopensearchservice_buffering_hints.zig").AmazonopensearchserviceBufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const DocumentIdOptions = @import("document_id_options.zig").DocumentIdOptions;
const AmazonopensearchserviceIndexRotationPeriod = @import("amazonopensearchservice_index_rotation_period.zig").AmazonopensearchserviceIndexRotationPeriod;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const AmazonopensearchserviceRetryOptions = @import("amazonopensearchservice_retry_options.zig").AmazonopensearchserviceRetryOptions;
const S3DestinationUpdate = @import("s3_destination_update.zig").S3DestinationUpdate;

/// Describes an update for a destination in Amazon OpenSearch Service.
pub const AmazonopensearchserviceDestinationUpdate = struct {
    /// The buffering options. If no value is specified,
    /// AmazonopensearchBufferingHints object
    /// default values are used.
    buffering_hints: ?AmazonopensearchserviceBufferingHints = null,

    cloud_watch_logging_options: ?CloudWatchLoggingOptions = null,

    /// The endpoint to use when communicating with the cluster. Specify either this
    /// ClusterEndpoint or the DomainARN field.
    cluster_endpoint: ?[]const u8 = null,

    /// Indicates the method for setting up document ID. The supported methods are
    /// Firehose generated document ID and OpenSearch Service generated document ID.
    document_id_options: ?DocumentIdOptions = null,

    /// The ARN of the Amazon OpenSearch Service domain. The IAM role must have
    /// permissions for
    /// DescribeDomain, DescribeDomains, and DescribeDomainConfig after assuming the
    /// IAM role
    /// specified in RoleARN.
    domain_arn: ?[]const u8 = null,

    /// The Amazon OpenSearch Service index name.
    index_name: ?[]const u8 = null,

    /// The Amazon OpenSearch Service index rotation period. Index rotation appends
    /// a timestamp
    /// to IndexName to facilitate the expiration of old data.
    index_rotation_period: ?AmazonopensearchserviceIndexRotationPeriod = null,

    processing_configuration: ?ProcessingConfiguration = null,

    /// The retry behavior in case Firehose is unable to deliver documents to
    /// Amazon OpenSearch Service. The default value is 300 (5 minutes).
    retry_options: ?AmazonopensearchserviceRetryOptions = null,

    /// The Amazon Resource Name (ARN) of the IAM role to be assumed by Firehose
    /// for calling the Amazon OpenSearch Service Configuration API and for indexing
    /// documents.
    role_arn: ?[]const u8 = null,

    s3_update: ?S3DestinationUpdate = null,

    /// The Amazon OpenSearch Service type name. For Elasticsearch 6.x, there can be
    /// only one
    /// type per index. If you try to specify a new type for an existing index that
    /// already has
    /// another type, Firehose returns an error during runtime.
    ///
    /// If you upgrade Elasticsearch from 6.x to 7.x and don’t update your Firehose
    /// stream,
    /// Firehose still delivers data to Elasticsearch with the old index name and
    /// type
    /// name. If you want to update your Firehose stream with a new index name,
    /// provide an empty
    /// string for TypeName.
    type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .buffering_hints = "BufferingHints",
        .cloud_watch_logging_options = "CloudWatchLoggingOptions",
        .cluster_endpoint = "ClusterEndpoint",
        .document_id_options = "DocumentIdOptions",
        .domain_arn = "DomainARN",
        .index_name = "IndexName",
        .index_rotation_period = "IndexRotationPeriod",
        .processing_configuration = "ProcessingConfiguration",
        .retry_options = "RetryOptions",
        .role_arn = "RoleARN",
        .s3_update = "S3Update",
        .type_name = "TypeName",
    };
};
