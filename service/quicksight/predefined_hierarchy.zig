const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const DrillDownFilter = @import("drill_down_filter.zig").DrillDownFilter;

/// The option that determines the hierarchy of the fields that are defined
/// during data preparation. These fields are available to use in any analysis
/// that uses the data source.
pub const PredefinedHierarchy = struct {
    /// The list of columns that define the predefined hierarchy.
    columns: []const ColumnIdentifier,

    /// The option that determines the drill down filters for the predefined
    /// hierarchy.
    drill_down_filters: ?[]const DrillDownFilter,

    /// The hierarchy ID of the predefined hierarchy.
    hierarchy_id: []const u8,

    pub const json_field_names = .{
        .columns = "Columns",
        .drill_down_filters = "DrillDownFilters",
        .hierarchy_id = "HierarchyId",
    };
};
