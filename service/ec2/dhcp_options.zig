const DhcpConfiguration = @import("dhcp_configuration.zig").DhcpConfiguration;
const Tag = @import("tag.zig").Tag;

/// The set of DHCP options.
pub const DhcpOptions = struct {
    /// The DHCP options in the set.
    dhcp_configurations: ?[]const DhcpConfiguration = null,

    /// The ID of the set of DHCP options.
    dhcp_options_id: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the DHCP options set.
    owner_id: ?[]const u8 = null,

    /// Any tags assigned to the DHCP options set.
    tags: ?[]const Tag = null,
};
