const ElasticsearchBufferingHints = @import("elasticsearch_buffering_hints.zig").ElasticsearchBufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const DocumentIdOptions = @import("document_id_options.zig").DocumentIdOptions;
const ElasticsearchIndexRotationPeriod = @import("elasticsearch_index_rotation_period.zig").ElasticsearchIndexRotationPeriod;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const ElasticsearchRetryOptions = @import("elasticsearch_retry_options.zig").ElasticsearchRetryOptions;
const ElasticsearchS3BackupMode = @import("elasticsearch_s3_backup_mode.zig").ElasticsearchS3BackupMode;
const S3DestinationConfiguration = @import("s3_destination_configuration.zig").S3DestinationConfiguration;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;

/// Describes the configuration of a destination in Amazon OpenSearch Service.
pub const ElasticsearchDestinationConfiguration = struct {
    /// The buffering options. If no value is specified, the default values for
    /// `ElasticsearchBufferingHints` are used.
    buffering_hints: ?ElasticsearchBufferingHints = null,

    /// The Amazon CloudWatch logging options for your Firehose stream.
    cloud_watch_logging_options: ?CloudWatchLoggingOptions = null,

    /// The endpoint to use when communicating with the cluster. Specify either this
    /// `ClusterEndpoint` or the `DomainARN` field.
    cluster_endpoint: ?[]const u8 = null,

    /// Indicates the method for setting up document ID. The supported methods are
    /// Firehose generated document ID and OpenSearch Service generated document ID.
    document_id_options: ?DocumentIdOptions = null,

    /// The ARN of the Amazon OpenSearch Service domain. The IAM role must have
    /// permissions
    /// for `DescribeDomain`, `DescribeDomains`, and
    /// `DescribeDomainConfig` after assuming the role specified in **RoleARN**. For
    /// more information, see [Amazon Resource Names (ARNs) and
    /// Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    ///
    /// Specify either `ClusterEndpoint` or `DomainARN`.
    domain_arn: ?[]const u8 = null,

    /// The Elasticsearch index name.
    index_name: []const u8,

    /// The Elasticsearch index rotation period. Index rotation appends a timestamp
    /// to the
    /// `IndexName` to facilitate the expiration of old data. For more information,
    /// see [Index Rotation for the
    /// Amazon OpenSearch Service
    /// Destination](https://docs.aws.amazon.com/firehose/latest/dev/basic-deliver.html#es-index-rotation). The default value is `OneDay`.
    index_rotation_period: ?ElasticsearchIndexRotationPeriod = null,

    /// The data processing configuration.
    processing_configuration: ?ProcessingConfiguration = null,

    /// The retry behavior in case Firehose is unable to deliver documents to
    /// Amazon OpenSearch Service. The default value is 300 (5 minutes).
    retry_options: ?ElasticsearchRetryOptions = null,

    /// The Amazon Resource Name (ARN) of the IAM role to be assumed by Firehose
    /// for calling the Amazon OpenSearch Service Configuration API and for indexing
    /// documents. For more
    /// information, see [Grant Firehose Access to an Amazon S3
    /// Destination](https://docs.aws.amazon.com/firehose/latest/dev/controlling-access.html#using-iam-s3) and [Amazon Resource Names (ARNs) and
    /// Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    role_arn: []const u8,

    /// Defines how documents should be delivered to Amazon S3. When it is set to
    /// `FailedDocumentsOnly`, Firehose writes any documents that could
    /// not be indexed to the configured Amazon S3 destination, with
    /// `AmazonOpenSearchService-failed/` appended to the key prefix. When set to
    /// `AllDocuments`, Firehose delivers all incoming records to Amazon
    /// S3, and also writes failed documents with `AmazonOpenSearchService-failed/`
    /// appended to the prefix. For more information, see [Amazon S3 Backup for the
    /// Amazon OpenSearch Service
    /// Destination](https://docs.aws.amazon.com/firehose/latest/dev/basic-deliver.html#es-s3-backup). Default value is
    /// `FailedDocumentsOnly`.
    ///
    /// You can't change this backup mode after you create the Firehose stream.
    s3_backup_mode: ?ElasticsearchS3BackupMode = null,

    /// The configuration for the backup Amazon S3 location.
    s3_configuration: S3DestinationConfiguration,

    /// The Elasticsearch type name. For Elasticsearch 6.x, there can be only one
    /// type per
    /// index. If you try to specify a new type for an existing index that already
    /// has another
    /// type, Firehose returns an error during run time.
    ///
    /// For Elasticsearch 7.x, don't specify a `TypeName`.
    type_name: ?[]const u8 = null,

    /// The details of the VPC of the Amazon destination.
    vpc_configuration: ?VpcConfiguration = null,

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
        .s3_backup_mode = "S3BackupMode",
        .s3_configuration = "S3Configuration",
        .type_name = "TypeName",
        .vpc_configuration = "VpcConfiguration",
    };
};
