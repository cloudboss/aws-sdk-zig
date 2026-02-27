const VpcEndpoint = @import("vpc_endpoint.zig").VpcEndpoint;

/// The VPC endpoint object.
pub const Endpoint = struct {
    /// The DNS address of the VPC endpoint.
    address: ?[]const u8,

    /// The port that Amazon Redshift Serverless listens on.
    port: ?i32,

    /// An array of `VpcEndpoint` objects.
    vpc_endpoints: ?[]const VpcEndpoint,

    pub const json_field_names = .{
        .address = "address",
        .port = "port",
        .vpc_endpoints = "vpcEndpoints",
    };
};
