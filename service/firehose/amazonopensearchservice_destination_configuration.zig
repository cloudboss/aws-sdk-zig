const AmazonopensearchserviceBufferingHints = @import("amazonopensearchservice_buffering_hints.zig").AmazonopensearchserviceBufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const DocumentIdOptions = @import("document_id_options.zig").DocumentIdOptions;
const AmazonopensearchserviceIndexRotationPeriod = @import("amazonopensearchservice_index_rotation_period.zig").AmazonopensearchserviceIndexRotationPeriod;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const AmazonopensearchserviceRetryOptions = @import("amazonopensearchservice_retry_options.zig").AmazonopensearchserviceRetryOptions;
const AmazonopensearchserviceS3BackupMode = @import("amazonopensearchservice_s3_backup_mode.zig").AmazonopensearchserviceS3BackupMode;
const S3DestinationConfiguration = @import("s3_destination_configuration.zig").S3DestinationConfiguration;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;

/// Describes the configuration of a destination in Amazon OpenSearch Service
pub const AmazonopensearchserviceDestinationConfiguration = struct {
    /// The buffering options. If no value is specified, the default values for
    /// AmazonopensearchserviceBufferingHints are used.
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
    /// DescribeElasticsearchDomain, DescribeElasticsearchDomains, and
    /// DescribeElasticsearchDomainConfig after assuming the role specified in
    /// RoleARN.
    domain_arn: ?[]const u8 = null,

    /// The ElasticsearAmazon OpenSearch Service index name.
    index_name: []const u8,

    /// The Amazon OpenSearch Service index rotation period. Index rotation appends
    /// a timestamp
    /// to the IndexName to facilitate the expiration of old data.
    index_rotation_period: ?AmazonopensearchserviceIndexRotationPeriod = null,

    processing_configuration: ?ProcessingConfiguration = null,

    /// The retry behavior in case Firehose is unable to deliver documents to
    /// Amazon OpenSearch Service. The default value is 300 (5 minutes).
    retry_options: ?AmazonopensearchserviceRetryOptions = null,

    /// The Amazon Resource Name (ARN) of the IAM role to be assumed by Firehose
    /// for calling the Amazon OpenSearch Service Configuration API and for indexing
    /// documents.
    role_arn: []const u8,

    /// Defines how documents should be delivered to Amazon S3. When it is set to
    /// FailedDocumentsOnly, Firehose writes any documents that could not be indexed
    /// to the configured Amazon S3 destination, with
    /// AmazonOpenSearchService-failed/ appended to
    /// the key prefix. When set to AllDocuments, Firehose delivers all incoming
    /// records to Amazon S3, and also writes failed documents with
    /// AmazonOpenSearchService-failed/
    /// appended to the prefix.
    s3_backup_mode: ?AmazonopensearchserviceS3BackupMode = null,

    s3_configuration: S3DestinationConfiguration,

    /// The Amazon OpenSearch Service type name. For Elasticsearch 6.x, there can be
    /// only one
    /// type per index. If you try to specify a new type for an existing index that
    /// already has
    /// another type, Firehose returns an error during run time.
    type_name: ?[]const u8 = null,

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
