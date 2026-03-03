const NetworkType = @import("network_type.zig").NetworkType;

/// The networking configuration for the cluster's control plane.
pub const NetworkingRequest = struct {
    /// The IP address version the cluster uses. The default is `IPV4`.
    network_type: ?NetworkType = null,

    /// A list of security group IDs associated with the Elastic Network Interface
    /// (ENI) created in subnets.
    security_group_ids: ?[]const []const u8 = null,

    /// The list of subnet IDs where PCS creates an Elastic Network Interface (ENI)
    /// to enable communication between managed controllers and PCS resources.
    /// Subnet IDs have the form `subnet-0123456789abcdef0`.
    ///
    /// Subnets can't be in Outposts, Wavelength or an Amazon Web Services Local
    /// Zone.
    ///
    /// PCS currently supports only 1 subnet in this list.
    subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .network_type = "networkType",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
    };
};
