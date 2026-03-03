const PortRange = @import("port_range.zig").PortRange;

/// Describes a header. Reflects any changes made by a component as traffic
/// passes through.
/// The fields of an inbound header are null except for the first component of a
/// path.
pub const AnalysisPacketHeader = struct {
    /// The destination addresses.
    destination_addresses: ?[]const []const u8 = null,

    /// The destination port ranges.
    destination_port_ranges: ?[]const PortRange = null,

    /// The protocol.
    protocol: ?[]const u8 = null,

    /// The source addresses.
    source_addresses: ?[]const []const u8 = null,

    /// The source port ranges.
    source_port_ranges: ?[]const PortRange = null,
};
