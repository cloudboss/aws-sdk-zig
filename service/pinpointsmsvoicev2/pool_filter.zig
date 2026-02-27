const PoolFilterName = @import("pool_filter_name.zig").PoolFilterName;

/// The information for a pool that meets a specified criteria.
pub const PoolFilter = struct {
    /// The name of the attribute to filter on.
    name: PoolFilterName,

    /// An array values to filter for.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
