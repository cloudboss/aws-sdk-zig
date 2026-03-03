const VerifiedAccessEndpointProtocol = @import("verified_access_endpoint_protocol.zig").VerifiedAccessEndpointProtocol;

/// Describes the RDS options for a Verified Access endpoint.
pub const CreateVerifiedAccessEndpointRdsOptions = struct {
    /// The port.
    port: ?i32 = null,

    /// The protocol.
    protocol: ?VerifiedAccessEndpointProtocol = null,

    /// The ARN of the DB cluster.
    rds_db_cluster_arn: ?[]const u8 = null,

    /// The ARN of the RDS instance.
    rds_db_instance_arn: ?[]const u8 = null,

    /// The ARN of the RDS proxy.
    rds_db_proxy_arn: ?[]const u8 = null,

    /// The RDS endpoint.
    rds_endpoint: ?[]const u8 = null,

    /// The IDs of the subnets. You can specify only one subnet per Availability
    /// Zone.
    subnet_ids: ?[]const []const u8 = null,
};
