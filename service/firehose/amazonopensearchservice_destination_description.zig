const AmazonopensearchserviceBufferingHints = @import("amazonopensearchservice_buffering_hints.zig").AmazonopensearchserviceBufferingHints;
const CloudWatchLoggingOptions = @import("cloud_watch_logging_options.zig").CloudWatchLoggingOptions;
const DocumentIdOptions = @import("document_id_options.zig").DocumentIdOptions;
const AmazonopensearchserviceIndexRotationPeriod = @import("amazonopensearchservice_index_rotation_period.zig").AmazonopensearchserviceIndexRotationPeriod;
const ProcessingConfiguration = @import("processing_configuration.zig").ProcessingConfiguration;
const AmazonopensearchserviceRetryOptions = @import("amazonopensearchservice_retry_options.zig").AmazonopensearchserviceRetryOptions;
const AmazonopensearchserviceS3BackupMode = @import("amazonopensearchservice_s3_backup_mode.zig").AmazonopensearchserviceS3BackupMode;
const S3DestinationDescription = @import("s3_destination_description.zig").S3DestinationDescription;
const VpcConfigurationDescription = @import("vpc_configuration_description.zig").VpcConfigurationDescription;

/// The destination description in Amazon OpenSearch Service.
pub const AmazonopensearchserviceDestinationDescription = struct {
    /// The buffering options.
    buffering_hints: ?AmazonopensearchserviceBufferingHints,

    cloud_watch_logging_options: ?CloudWatchLoggingOptions,

    /// The endpoint to use when communicating with the cluster. Firehose uses
    /// either this ClusterEndpoint or the DomainARN field to send data to Amazon
    /// OpenSearch
    /// Service.
    cluster_endpoint: ?[]const u8,

    /// Indicates the method for setting up document ID. The supported methods are
    /// Firehose generated document ID and OpenSearch Service generated document ID.
    document_id_options: ?DocumentIdOptions,

    /// The ARN of the Amazon OpenSearch Service domain.
    domain_arn: ?[]const u8,

    /// The Amazon OpenSearch Service index name.
    index_name: ?[]const u8,

    /// The Amazon OpenSearch Service index rotation period
    index_rotation_period: ?AmazonopensearchserviceIndexRotationPeriod,

    processing_configuration: ?ProcessingConfiguration,

    /// The Amazon OpenSearch Service retry options.
    retry_options: ?AmazonopensearchserviceRetryOptions,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services credentials.
    role_arn: ?[]const u8,

    /// The Amazon S3 backup mode.
    s3_backup_mode: ?AmazonopensearchserviceS3BackupMode,

    s3_destination_description: ?S3DestinationDescription,

    /// The Amazon OpenSearch Service type name. This applies to Elasticsearch 6.x
    /// and lower
    /// versions. For Elasticsearch 7.x and OpenSearch Service 1.x, there's no value
    /// for TypeName.
    type_name: ?[]const u8,

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
