const VpcEndpointType = @import("vpc_endpoint_type.zig").VpcEndpointType;

/// The configuration for a service network endpoint.
pub const ServiceNetworkEndpoint = struct {
    /// The identifier of the VPC endpoint.
    vpc_endpoint_id: ?[]const u8,

    /// The type of the VPC endpoint.
    vpc_endpoint_type: ?VpcEndpointType,

    pub const json_field_names = .{
        .vpc_endpoint_id = "vpcEndpointId",
        .vpc_endpoint_type = "vpcEndpointType",
    };
};
