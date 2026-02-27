const MatchOption = @import("match_option.zig").MatchOption;
const ListUsageFilterName = @import("list_usage_filter_name.zig").ListUsageFilterName;

/// Represents a filter for listing usage data.
pub const ListUsageFilter = struct {
    /// The match option for the filter (e.g., equals, contains).
    match_option: ?MatchOption,

    /// The name of the filter attribute.
    name: ListUsageFilterName,

    /// The values to filter by.
    values: []const []const u8,

    pub const json_field_names = .{
        .match_option = "matchOption",
        .name = "name",
        .values = "values",
    };
};
