const PipelineEndpointStatus = @import("pipeline_endpoint_status.zig").PipelineEndpointStatus;

/// Represents a connection to a pipeline endpoint, containing details about the
/// endpoint
/// association.
pub const PipelineEndpointConnection = struct {
    /// The unique identifier of the endpoint in the connection.
    endpoint_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the pipeline in the endpoint connection.
    pipeline_arn: ?[]const u8,

    /// The current status of the pipeline endpoint connection.
    status: ?PipelineEndpointStatus,

    /// The Amazon Web Services account ID that owns the VPC endpoint used in this
    /// connection.
    vpc_endpoint_owner: ?[]const u8,

    pub const json_field_names = .{
        .endpoint_id = "EndpointId",
        .pipeline_arn = "PipelineArn",
        .status = "Status",
        .vpc_endpoint_owner = "VpcEndpointOwner",
    };
};
