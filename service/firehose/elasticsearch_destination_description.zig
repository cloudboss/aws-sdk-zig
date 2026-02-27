const ElasticsearchBufferingHints = @import("elasticsearch_buffering_hints.zig").ElasticsearchBufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const DocumentIdOptions = @import("document_id_options.zig").DocumentIdOptions;
const ElasticsearchIndexRotationPeriod = @import("elasticsearch_index_rotation_period.zig").ElasticsearchIndexRotationPeriod;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const ElasticsearchRetryOptions = @import("elasticsearch_retry_options.zig").ElasticsearchRetryOptions;
const ElasticsearchS3BackupMode = @import("elasticsearch_s3_backup_mode.zig").ElasticsearchS3BackupMode;
const S3DestinationDescription = @import("s3_destination_description.zig").S3DestinationDescription;
const VpcConfigurationDescription = @import("vpc_configuration_description.zig").VpcConfigurationDescription;

/// The destination description in Amazon OpenSearch Service.
pub const ElasticsearchDestinationDescription = struct {
    /// The buffering options.
    buffering_hints: ?ElasticsearchBufferingHints,

    /// The Amazon CloudWatch logging options.
    cloud_watch_logging_options: ?CloudWatchLoggingOptions,

    /// The endpoint to use when communicating with the cluster. Firehose uses
    /// either this `ClusterEndpoint` or the `DomainARN` field to send data
    /// to Amazon OpenSearch Service.
    cluster_endpoint: ?[]const u8,

    /// Indicates the method for setting up document ID. The supported methods are
    /// Firehose generated document ID and OpenSearch Service generated document ID.
    document_id_options: ?DocumentIdOptions,

    /// The ARN of the Amazon OpenSearch Service domain. For more information, see
    /// [Amazon
    /// Resource Names (ARNs) and Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    ///
    /// Firehose uses either `ClusterEndpoint` or `DomainARN`
    /// to send data to Amazon OpenSearch Service.
    domain_arn: ?[]const u8,

    /// The Elasticsearch index name.
    index_name: ?[]const u8,

    /// The Elasticsearch index rotation period
    index_rotation_period: ?ElasticsearchIndexRotationPeriod,

    /// The data processing configuration.
    processing_configuration: ?ProcessingConfiguration,

    /// The Amazon OpenSearch Service retry options.
    retry_options: ?ElasticsearchRetryOptions,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services credentials. For
    /// more
    /// information, see [Amazon Resource Names (ARNs) and
    /// Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html).
    role_arn: ?[]const u8,

    /// The Amazon S3 backup mode.
    s3_backup_mode: ?ElasticsearchS3BackupMode,

    /// The Amazon S3 destination.
    s3_destination_description: ?S3DestinationDescription,

    /// The Elasticsearch type name. This applies to Elasticsearch 6.x and lower
    /// versions.
    /// For Elasticsearch 7.x and OpenSearch Service 1.x, there's no value for
    /// `TypeName`.
    type_name: ?[]const u8,

    /// The details of the VPC of the Amazon OpenSearch or the Amazon OpenSearch
    /// Serverless
    /// destination.
    vpc_configuration_description: ?VpcConfigurationDescription,

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
        .s3_destination_description = "S3DestinationDescription",
        .type_name = "TypeName",
        .vpc_configuration_description = "VpcConfigurationDescription",
    };
};
