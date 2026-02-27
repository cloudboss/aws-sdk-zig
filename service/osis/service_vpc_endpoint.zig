const VpcEndpointServiceName = @import("vpc_endpoint_service_name.zig").VpcEndpointServiceName;

/// A container for information about VPC endpoints that were created to other
/// services
pub const ServiceVpcEndpoint = struct {
    /// The name of the service for which a VPC endpoint was created.
    service_name: ?VpcEndpointServiceName,

    /// The unique identifier of the VPC endpoint that was created.
    vpc_endpoint_id: ?[]const u8,

    pub const json_field_names = .{
        .service_name = "ServiceName",
        .vpc_endpoint_id = "VpcEndpointId",
    };
};
