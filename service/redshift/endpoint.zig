const VpcEndpoint = @import("vpc_endpoint.zig").VpcEndpoint;

/// Describes a connection endpoint.
pub const Endpoint = struct {
    /// The DNS address of the Cluster.
    address: ?[]const u8 = null,

    /// The port that the database engine is listening on.
    port: ?i32 = null,

    /// Describes a connection endpoint.
    vpc_endpoints: ?[]const VpcEndpoint = null,
};
