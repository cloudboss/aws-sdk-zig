const SpaceQuickSightSearchFilterName = @import("space_quick_sight_search_filter_name.zig").SpaceQuickSightSearchFilterName;
const SpaceSearchOperator = @import("space_search_operator.zig").SpaceSearchOperator;

/// A filter to use when searching for spaces.
pub const SpaceQuicksightSearchFilter = struct {
    /// The name of the filter field to use.
    name: SpaceQuickSightSearchFilterName,

    /// The comparison operator to use for the filter.
    operator: SpaceSearchOperator,

    /// The value to use for the filter.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .value = "value",
    };
};
