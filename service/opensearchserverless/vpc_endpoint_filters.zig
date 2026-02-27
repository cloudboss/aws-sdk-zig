const VpcEndpointStatus = @import("vpc_endpoint_status.zig").VpcEndpointStatus;

/// Filter the results of a `ListVpcEndpoints` request.
pub const VpcEndpointFilters = struct {
    /// The current status of the endpoint.
    status: ?VpcEndpointStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};
