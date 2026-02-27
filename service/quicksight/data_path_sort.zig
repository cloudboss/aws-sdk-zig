const SortDirection = @import("sort_direction.zig").SortDirection;
const DataPathValue = @import("data_path_value.zig").DataPathValue;

/// Allows data paths to be sorted by a specific data value.
pub const DataPathSort = struct {
    /// Determines the sort direction.
    direction: SortDirection,

    /// The list of data paths that need to be sorted.
    sort_paths: []const DataPathValue,

    pub const json_field_names = .{
        .direction = "Direction",
        .sort_paths = "SortPaths",
    };
};
