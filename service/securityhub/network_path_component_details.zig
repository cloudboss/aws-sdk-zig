const PortRange = @import("port_range.zig").PortRange;

/// Information about the destination of the next component in the network path.
pub const NetworkPathComponentDetails = struct {
    /// The IP addresses of the destination.
    address: ?[]const []const u8 = null,

    /// A list of port ranges for the destination.
    port_ranges: ?[]const PortRange = null,

    pub const json_field_names = .{
        .address = "Address",
        .port_ranges = "PortRanges",
    };
};
