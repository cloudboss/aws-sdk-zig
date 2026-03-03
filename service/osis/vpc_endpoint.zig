const VpcOptions = @import("vpc_options.zig").VpcOptions;

/// An OpenSearch Ingestion-managed VPC endpoint that will access one or more
/// pipelines.
pub const VpcEndpoint = struct {
    /// The unique identifier of the endpoint.
    vpc_endpoint_id: ?[]const u8 = null,

    /// The ID for your VPC. Amazon Web Services PrivateLink generates this value
    /// when you create a
    /// VPC.
    vpc_id: ?[]const u8 = null,

    /// Information about the VPC, including associated subnets and security groups.
    vpc_options: ?VpcOptions = null,

    pub const json_field_names = .{
        .vpc_endpoint_id = "VpcEndpointId",
        .vpc_id = "VpcId",
        .vpc_options = "VpcOptions",
    };
};
