/// Contains the details about the available and supported bandwidths.
pub const Bandwidths = struct {
    /// The list of currently available bandwidths.
    available: ?[]const []const u8 = null,

    /// The list of all bandwidths that this environment plans to support
    supported: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .available = "available",
        .supported = "supported",
    };
};
