const SearchAppsFilterName = @import("search_apps_filter_name.zig").SearchAppsFilterName;
const FilterOperator = @import("filter_operator.zig").FilterOperator;

/// A filter to apply when searching for apps.
pub const SearchAppsFilter = struct {
    /// The name of the filter attribute.
    name: SearchAppsFilterName,

    /// The comparison operator for the filter.
    operator: FilterOperator,

    /// The value to filter on.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .operator = "Operator",
        .value = "Value",
    };
};
