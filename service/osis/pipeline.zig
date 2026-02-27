const BufferOptions = @import("buffer_options.zig").BufferOptions;
const PipelineDestination = @import("pipeline_destination.zig").PipelineDestination;
const EncryptionAtRestOptions = @import("encryption_at_rest_options.zig").EncryptionAtRestOptions;
const LogPublishingOptions = @import("log_publishing_options.zig").LogPublishingOptions;
const ServiceVpcEndpoint = @import("service_vpc_endpoint.zig").ServiceVpcEndpoint;
const PipelineStatus = @import("pipeline_status.zig").PipelineStatus;
const PipelineStatusReason = @import("pipeline_status_reason.zig").PipelineStatusReason;
const Tag = @import("tag.zig").Tag;
const VpcEndpoint = @import("vpc_endpoint.zig").VpcEndpoint;

/// Information about an existing OpenSearch Ingestion pipeline.
pub const Pipeline = struct {
    buffer_options: ?BufferOptions,

    /// The date and time when the pipeline was created.
    created_at: ?i64,

    /// Destinations to which the pipeline writes data.
    destinations: ?[]const PipelineDestination,

    encryption_at_rest_options: ?EncryptionAtRestOptions,

    /// The ingestion endpoints for the pipeline, which you can send data to.
    ingest_endpoint_urls: ?[]const []const u8,

    /// The date and time when the pipeline was last updated.
    last_updated_at: ?i64,

    /// Key-value pairs that represent log publishing settings.
    log_publishing_options: ?LogPublishingOptions,

    /// The maximum pipeline capacity, in Ingestion Compute Units (ICUs).
    max_units: i32 = 0,

    /// The minimum pipeline capacity, in Ingestion Compute Units (ICUs).
    min_units: i32 = 0,

    /// The Amazon Resource Name (ARN) of the pipeline.
    pipeline_arn: ?[]const u8,

    /// The Data Prepper pipeline configuration in YAML format.
    pipeline_configuration_body: ?[]const u8,

    /// The name of the pipeline.
    pipeline_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that the pipeline uses to
    /// access AWS
    /// resources.
    pipeline_role_arn: ?[]const u8,

    /// A list of VPC endpoints that OpenSearch Ingestion has created to other
    /// Amazon Web Services services.
    service_vpc_endpoints: ?[]const ServiceVpcEndpoint,

    /// The current status of the pipeline.
    status: ?PipelineStatus,

    /// The reason for the current status of the pipeline.
    status_reason: ?PipelineStatusReason,

    /// A list of tags associated with the given pipeline.
    tags: ?[]const Tag,

    /// The VPC interface endpoints that have access to the pipeline.
    vpc_endpoints: ?[]const VpcEndpoint,

    /// The VPC endpoint service name for the pipeline.
    vpc_endpoint_service: ?[]const u8,

    pub const json_field_names = .{
        .buffer_options = "BufferOptions",
        .created_at = "CreatedAt",
        .destinations = "Destinations",
        .encryption_at_rest_options = "EncryptionAtRestOptions",
        .ingest_endpoint_urls = "IngestEndpointUrls",
        .last_updated_at = "LastUpdatedAt",
        .log_publishing_options = "LogPublishingOptions",
        .max_units = "MaxUnits",
        .min_units = "MinUnits",
        .pipeline_arn = "PipelineArn",
        .pipeline_configuration_body = "PipelineConfigurationBody",
        .pipeline_name = "PipelineName",
        .pipeline_role_arn = "PipelineRoleArn",
        .service_vpc_endpoints = "ServiceVpcEndpoints",
        .status = "Status",
        .status_reason = "StatusReason",
        .tags = "Tags",
        .vpc_endpoints = "VpcEndpoints",
        .vpc_endpoint_service = "VpcEndpointService",
    };
};
