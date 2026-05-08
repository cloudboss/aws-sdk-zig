const NetworkAccessType = @import("network_access_type.zig").NetworkAccessType;

/// The network configuration for a notebook run in Amazon DataZone.
pub const NetworkConfig = struct {
    /// The network access type for the notebook run. Valid values are
    /// `PUBLIC_INTERNET_ONLY` and `VPC_ONLY`.
    network_access_type: NetworkAccessType,

    /// The identifiers of the security groups for the notebook run. You can specify
    /// up to 5 security groups.
    security_group_ids: ?[]const []const u8 = null,

    /// The identifiers of the subnets for the notebook run. You can specify up to
    /// 10 subnets.
    subnet_ids: ?[]const []const u8 = null,

    /// The identifier of the VPC for the notebook run. This is required when the
    /// network access type is `VPC_ONLY`.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .network_access_type = "networkAccessType",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};
