const VpcEndpointStatus = @import("vpc_endpoint_status.zig").VpcEndpointStatus;

/// Deletion details for an OpenSearch Serverless-managed interface endpoint.
pub const DeleteVpcEndpointDetail = struct {
    /// The unique identifier of the endpoint.
    id: ?[]const u8 = null,

    /// The name of the endpoint.
    name: ?[]const u8 = null,

    /// The current status of the endpoint deletion process.
    status: ?VpcEndpointStatus = null,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .status = "status",
    };
};
