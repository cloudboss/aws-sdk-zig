const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const DrillDownFilter = @import("drill_down_filter.zig").DrillDownFilter;

/// The option that determines the hierarchy of the fields that are built within
/// a visual's field wells. These fields can't be duplicated to other visuals.
pub const ExplicitHierarchy = struct {
    /// The list of columns that define the explicit hierarchy.
    columns: []const ColumnIdentifier,

    /// The option that determines the drill down filters for the explicit
    /// hierarchy.
    drill_down_filters: ?[]const DrillDownFilter = null,

    /// The hierarchy ID of the explicit hierarchy.
    hierarchy_id: []const u8,

    pub const json_field_names = .{
        .columns = "Columns",
        .drill_down_filters = "DrillDownFilters",
        .hierarchy_id = "HierarchyId",
    };
};
