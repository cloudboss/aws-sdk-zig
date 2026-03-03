/// The RDS options for a Verified Access endpoint.
pub const ModifyVerifiedAccessEndpointRdsOptions = struct {
    /// The port.
    port: ?i32 = null,

    /// The RDS endpoint.
    rds_endpoint: ?[]const u8 = null,

    /// The IDs of the subnets.
    subnet_ids: ?[]const []const u8 = null,
};
