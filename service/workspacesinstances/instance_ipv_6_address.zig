/// Represents an IPv6 address configuration for a WorkSpace Instance.
pub const InstanceIpv6Address = struct {
    /// Specific IPv6 address assigned to the instance.
    ipv_6_address: ?[]const u8 = null,

    /// Indicates if this is the primary IPv6 address for the instance.
    is_primary_ipv_6: ?bool = null,

    pub const json_field_names = .{
        .ipv_6_address = "Ipv6Address",
        .is_primary_ipv_6 = "IsPrimaryIpv6",
    };
};
