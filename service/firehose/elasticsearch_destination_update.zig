const ElasticsearchBufferingHints = @import("elasticsearch_buffering_hints.zig").ElasticsearchBufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const DocumentIdOptions = @import("document_id_options.zig").DocumentIdOptions;
const ElasticsearchIndexRotationPeriod = @import("elasticsearch_index_rotation_period.zig").ElasticsearchIndexRotationPeriod;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const ElasticsearchRetryOptions = @import("elasticsearch_retry_options.zig").ElasticsearchRetryOptions;
const S3DestinationUpdate = @import("s3_destination_update.zig").S3DestinationUpdate;

/// Describes an update for a destination in Amazon OpenSearch Service.
pub const ElasticsearchDestinationUpdate = struct {
    /// The buffering options. If no value is specified,
    /// `ElasticsearchBufferingHints` object default values are used.
    buffering_hints: ?ElasticsearchBufferingHints,

    /// The CloudWatch logging options for your Firehose stream.
    cloud_watch_logging_options: ?CloudWatchLoggingOptions,

    /// The endpoint to use when communicating with the cluster. Specify either this
    /// `ClusterEndpoint` or the `DomainARN` field.
    cluster_endpoint: ?[]const u8,

    /// Indicates the method for setting up document ID. The supported methods are
    /// Firehose generated document ID and OpenSearch Service generated document ID.
    document_id_options: ?DocumentIdOptions,

    /// The ARN of the Amazon OpenSearch Service domain. The IAM role must have
    /// permissions
    /// for `DescribeDomain`, `DescribeDomains`, and
    /// `DescribeDomainConfig` after assuming the IAM role specified in
    /// `RoleARN`. For more information, see [Amazon Resource Names (ARNs) and
    /// Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    ///
    /// Specify either `ClusterEndpoint` or `DomainARN`.
    domain_arn: ?[]const u8,

    /// The Elasticsearch index name.
    index_name: ?[]const u8,

    /// The Elasticsearch index rotation period. Index rotation appends a timestamp
    /// to
    /// `IndexName` to facilitate the expiration of old data. For more information,
    /// see [Index Rotation for the
    /// Amazon OpenSearch Service
    /// Destination](https://docs.aws.amazon.com/firehose/latest/dev/basic-deliver.html#es-index-rotation). Default value is `OneDay`.
    index_rotation_period: ?ElasticsearchIndexRotationPeriod,

    /// The data processing configuration.
    processing_configuration: ?ProcessingConfiguration,

    /// The retry behavior in case Firehose is unable to deliver documents to
    /// Amazon OpenSearch Service. The default value is 300 (5 minutes).
    retry_options: ?ElasticsearchRetryOptions,

    /// The Amazon Resource Name (ARN) of the IAM role to be assumed by Firehose
    /// for calling the Amazon OpenSearch Service Configuration API and for indexing
    /// documents. For more
    /// information, see [Grant Firehose Access to an Amazon S3
    /// Destination](https://docs.aws.amazon.com/firehose/latest/dev/controlling-access.html#using-iam-s3) and [Amazon Resource Names (ARNs) and
    /// Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    role_arn: ?[]const u8,

    /// The Amazon S3 destination.
    s3_update: ?S3DestinationUpdate,

    /// The Elasticsearch type name. For Elasticsearch 6.x, there can be only one
    /// type per
    /// index. If you try to specify a new type for an existing index that already
    /// has another
    /// type, Firehose returns an error during runtime.
    ///
    /// If you upgrade Elasticsearch from 6.x to 7.x and don’t update your Firehose
    /// stream,
    /// Firehose still delivers data to Elasticsearch with the old index name and
    /// type
    /// name. If you want to update your Firehose stream with a new index name,
    /// provide an empty
    /// string for `TypeName`.
    type_name: ?[]const u8,

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
