const RequestFilterPortRange = @import("request_filter_port_range.zig").RequestFilterPortRange;

/// Describes a set of filters for a path analysis. Use path filters to scope
/// the analysis when
/// there can be multiple resulting paths.
pub const PathRequestFilter = struct {
    /// The destination IPv4 address.
    destination_address: ?[]const u8 = null,

    /// The destination port range.
    destination_port_range: ?RequestFilterPortRange = null,

    /// The source IPv4 address.
    source_address: ?[]const u8 = null,

    /// The source port range.
    source_port_range: ?RequestFilterPortRange = null,
};
