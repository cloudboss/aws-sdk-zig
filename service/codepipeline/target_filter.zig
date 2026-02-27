const TargetFilterName = @import("target_filter_name.zig").TargetFilterName;

/// Filters the list of targets.
pub const TargetFilter = struct {
    /// The name on which to filter.
    name: ?TargetFilterName,

    /// The values on which to filter.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
