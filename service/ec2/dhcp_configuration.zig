const AttributeValue = @import("attribute_value.zig").AttributeValue;

/// Describes a DHCP configuration option.
pub const DhcpConfiguration = struct {
    /// The name of a DHCP option.
    key: ?[]const u8,

    /// The values for the DHCP option.
    values: ?[]const AttributeValue,
};
