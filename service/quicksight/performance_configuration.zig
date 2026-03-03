const UniqueKey = @import("unique_key.zig").UniqueKey;

/// The configuration for the performance optimization of the dataset that
/// contains a
/// `UniqueKey` configuration.
pub const PerformanceConfiguration = struct {
    /// A `UniqueKey` configuration.
    unique_keys: ?[]const UniqueKey = null,

    pub const json_field_names = .{
        .unique_keys = "UniqueKeys",
    };
};
