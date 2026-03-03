const VpcEndpoint = @import("vpc_endpoint.zig").VpcEndpoint;

/// The VPC endpoint object.
pub const Endpoint = struct {
    /// The DNS address of the VPC endpoint.
    address: ?[]const u8 = null,

    /// The port that Amazon Redshift Serverless listens on.
    port: ?i32 = null,

    /// An array of `VpcEndpoint` objects.
    vpc_endpoints: ?[]const VpcEndpoint = null,

    pub const json_field_names = .{
        .address = "address",
        .port = "port",
        .vpc_endpoints = "vpcEndpoints",
    };
};
