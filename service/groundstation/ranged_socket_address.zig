const IntegerRange = @import("integer_range.zig").IntegerRange;

/// A socket address with a port range.
pub const RangedSocketAddress = struct {
    /// IPv4 socket address.
    name: []const u8,

    /// Port range of a socket address.
    port_range: IntegerRange,

    pub const json_field_names = .{
        .name = "name",
        .port_range = "portRange",
    };
};
