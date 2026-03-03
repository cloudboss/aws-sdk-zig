const PipelineEndpointStatus = @import("pipeline_endpoint_status.zig").PipelineEndpointStatus;
const PipelineEndpointVpcOptions = @import("pipeline_endpoint_vpc_options.zig").PipelineEndpointVpcOptions;

/// Represents a VPC endpoint for an OpenSearch Ingestion pipeline, enabling
/// private
/// connectivity between your VPC and the pipeline.
pub const PipelineEndpoint = struct {
    /// The unique identifier for the pipeline endpoint.
    endpoint_id: ?[]const u8 = null,

    /// The URL used to ingest data to the pipeline through the VPC endpoint.
    ingest_endpoint_url: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the pipeline associated with this
    /// endpoint.
    pipeline_arn: ?[]const u8 = null,

    /// The current status of the pipeline endpoint.
    status: ?PipelineEndpointStatus = null,

    /// The ID of the VPC where the pipeline endpoint is created.
    vpc_id: ?[]const u8 = null,

    /// Configuration options for the VPC endpoint, including subnet and security
    /// group
    /// settings.
    vpc_options: ?PipelineEndpointVpcOptions = null,

    pub const json_field_names = .{
        .endpoint_id = "EndpointId",
        .ingest_endpoint_url = "IngestEndpointUrl",
        .pipeline_arn = "PipelineArn",
        .status = "Status",
        .vpc_id = "VpcId",
        .vpc_options = "VpcOptions",
    };
};
