const FilterName = @import("filter_name.zig").FilterName;

/// A filter used to restrict the results of describe calls. You can use
/// multiple
/// filters to return results that meet all applied filter requirements.
pub const Filter = struct {
    /// The name for this filter.
    name: ?FilterName = null,

    /// The values of the filter. These are all the values for any of the applied
    /// filters.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
