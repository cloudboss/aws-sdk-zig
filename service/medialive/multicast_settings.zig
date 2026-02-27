const MulticastSource = @import("multicast_source.zig").MulticastSource;

/// Settings for a Multicast input. Contains a list of multicast Urls and
/// optional source ip addresses.
pub const MulticastSettings = struct {
    sources: ?[]const MulticastSource,

    pub const json_field_names = .{
        .sources = "Sources",
    };
};
