/// General information about the IP set.
pub const IPSetMetadata = struct {
    /// Describes the total number of CIDR blocks currently in use by the IP set
    /// references in a firewall. To determine how many CIDR blocks are available
    /// for you to use in a firewall, you can call `AvailableCIDRCount`.
    resolved_cidr_count: ?i32,

    pub const json_field_names = .{
        .resolved_cidr_count = "ResolvedCIDRCount",
    };
};
