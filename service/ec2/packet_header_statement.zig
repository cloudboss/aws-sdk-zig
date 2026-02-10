const Protocol = @import("protocol.zig").Protocol;

/// Describes a packet header statement.
pub const PacketHeaderStatement = struct {
    /// The destination addresses.
    destination_addresses: ?[]const []const u8,

    /// The destination ports.
    destination_ports: ?[]const []const u8,

    /// The destination prefix lists.
    destination_prefix_lists: ?[]const []const u8,

    /// The protocols.
    protocols: ?[]const Protocol,

    /// The source addresses.
    source_addresses: ?[]const []const u8,

    /// The source ports.
    source_ports: ?[]const []const u8,

    /// The source prefix lists.
    source_prefix_lists: ?[]const []const u8,
};
