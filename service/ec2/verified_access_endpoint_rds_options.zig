const VerifiedAccessEndpointProtocol = @import("verified_access_endpoint_protocol.zig").VerifiedAccessEndpointProtocol;

/// Describes the RDS options for a Verified Access endpoint.
pub const VerifiedAccessEndpointRdsOptions = struct {
    /// The port.
    port: ?i32,

    /// The protocol.
    protocol: ?VerifiedAccessEndpointProtocol,

    /// The ARN of the DB cluster.
    rds_db_cluster_arn: ?[]const u8,

    /// The ARN of the RDS instance.
    rds_db_instance_arn: ?[]const u8,

    /// The ARN of the RDS proxy.
    rds_db_proxy_arn: ?[]const u8,

    /// The RDS endpoint.
    rds_endpoint: ?[]const u8,

    /// The IDs of the subnets.
    subnet_ids: ?[]const []const u8,
};
