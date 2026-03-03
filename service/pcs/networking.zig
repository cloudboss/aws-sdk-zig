const NetworkType = @import("network_type.zig").NetworkType;

/// The networking configuration for the cluster's control plane.
pub const Networking = struct {
    /// The IP address version the cluster uses. The default is `IPV4`.
    network_type: ?NetworkType = null,

    /// The list of security group IDs associated with the Elastic Network Interface
    /// (ENI) created in subnets.
    ///
    /// The following rules are required:
    ///
    /// * Inbound rule 1
    ///
    /// * Protocol: All
    /// * Ports: All
    /// * Source: Self
    ///
    /// * Outbound rule 1
    ///
    /// * Protocol: All
    /// * Ports: All
    /// * Destination: 0.0.0.0/0 (IPv4) or ::/0 (IPv6)
    ///
    /// * Outbound rule 2
    ///
    /// * Protocol: All
    /// * Ports: All
    /// * Destination: Self
    security_group_ids: ?[]const []const u8 = null,

    /// The ID of the subnet where PCS creates an Elastic Network Interface (ENI) to
    /// enable communication between managed controllers and PCS resources. The
    /// subnet must have an available IP address, cannot reside in Outposts,
    /// Wavelength, or an Amazon Web Services Local Zone.
    ///
    /// Example: `subnet-abcd1234`
    subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .network_type = "networkType",
        .security_group_ids = "securityGroupIds",
        .subnet_ids = "subnetIds",
    };
};
