const FirewallFailOpenStatus = @import("firewall_fail_open_status.zig").FirewallFailOpenStatus;

/// Configuration of the firewall behavior provided by DNS Firewall for a single
/// VPC from
/// Amazon Virtual Private Cloud (Amazon VPC).
pub const FirewallConfig = struct {
    /// Determines how DNS Firewall operates during failures, for example when all
    /// traffic that is sent to DNS Firewall fails to receive a reply.
    ///
    /// * By default, fail open is disabled, which means the failure mode is closed.
    ///   This approach favors security over availability. DNS Firewall returns
    /// a failure error when it is unable to properly evaluate a query.
    ///
    /// * If you enable this option, the failure mode is open. This approach favors
    ///   availability over security. DNS Firewall allows queries to proceed if it
    /// is unable to properly evaluate them.
    ///
    /// This behavior is only enforced for VPCs that have at least one DNS Firewall
    /// rule group association.
    firewall_fail_open: ?FirewallFailOpenStatus,

    /// The ID of the firewall configuration.
    id: ?[]const u8,

    /// The Amazon Web Services account ID of the owner of the VPC that this
    /// firewall configuration applies to.
    owner_id: ?[]const u8,

    /// The ID of the VPC that this firewall configuration applies to.
    resource_id: ?[]const u8,

    pub const json_field_names = .{
        .firewall_fail_open = "FirewallFailOpen",
        .id = "Id",
        .owner_id = "OwnerId",
        .resource_id = "ResourceId",
    };
};
