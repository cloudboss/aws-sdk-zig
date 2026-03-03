const DrillDownFilter = @import("drill_down_filter.zig").DrillDownFilter;

/// The option that determines the hierarchy of any `DateTime` fields.
pub const DateTimeHierarchy = struct {
    /// The option that determines the drill down filters for the
    /// `DateTime` hierarchy.
    drill_down_filters: ?[]const DrillDownFilter = null,

    /// The hierarchy ID of the `DateTime` hierarchy.
    hierarchy_id: []const u8,

    pub const json_field_names = .{
        .drill_down_filters = "DrillDownFilters",
        .hierarchy_id = "HierarchyId",
    };
};
