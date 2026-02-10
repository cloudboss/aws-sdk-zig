/// Describes a DHCP configuration option.
pub const NewDhcpConfiguration = struct {
    /// The name of a DHCP option.
    key: ?[]const u8,

    /// The values for the DHCP option.
    values: ?[]const []const u8,
};
