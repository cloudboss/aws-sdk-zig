const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const DefaultFilterControlConfiguration = @import("default_filter_control_configuration.zig").DefaultFilterControlConfiguration;
const HierarchyFilterLevel = @import("hierarchy_filter_level.zig").HierarchyFilterLevel;
const HierarchyFilterNode = @import("hierarchy_filter_node.zig").HierarchyFilterNode;
const HierarchyFilterMatchOperator = @import("hierarchy_filter_match_operator.zig").HierarchyFilterMatchOperator;
const FilterNullOption = @import("filter_null_option.zig").FilterNullOption;

/// A `HierarchyFilter` filters data by drilling down through an ordered list of
/// columns. Each level in the list narrows the data by one column, and the
/// selected values at each level determine which values are available at the
/// next.
pub const HierarchyFilter = struct {
    /// The column that anchors the filter. This column determines the dataset that
    /// the whole
    /// filter applies to, so every column in `HierarchyLevels` and in
    /// `HierarchyTree` must belong to the same dataset.
    column: ColumnIdentifier,

    /// The default configurations for the associated controls. This applies only
    /// for filters that are scoped to multiple sheets.
    default_filter_control_configuration: ?DefaultFilterControlConfiguration = null,

    /// An identifier that uniquely identifies a filter within a dashboard,
    /// analysis, or template.
    filter_id: []const u8,

    /// The ordered list of columns that defines the drill-down path of the filter.
    /// The first level is the top of the hierarchy. You can specify a maximum of 5
    /// levels.
    hierarchy_levels: []const HierarchyFilterLevel,

    /// The tree of selected values for the filter. Each node records the values
    /// that are selected at one level of the hierarchy, and its children record the
    /// selections beneath those values. Omit this attribute to define the
    /// drill-down path without restricting any values.
    hierarchy_tree: ?HierarchyFilterNode = null,

    /// Determines whether the values selected in `HierarchyTree` are kept or
    /// removed. Choose one of the following options:
    ///
    /// * `INCLUDE`: Keep only the selected values.
    ///
    /// * `EXCLUDE`: Remove the selected values.
    match_operator: HierarchyFilterMatchOperator,

    /// This option determines how null values should be treated when filtering
    /// data.
    ///
    /// * `ALL_VALUES`: Include null values in filtered results.
    ///
    /// * `NULLS_ONLY`: Only include null values in filtered results.
    ///
    /// * `NON_NULLS_ONLY`: Exclude null values from filtered results.
    null_option: FilterNullOption,

    pub const json_field_names = .{
        .column = "Column",
        .default_filter_control_configuration = "DefaultFilterControlConfiguration",
        .filter_id = "FilterId",
        .hierarchy_levels = "HierarchyLevels",
        .hierarchy_tree = "HierarchyTree",
        .match_operator = "MatchOperator",
        .null_option = "NullOption",
    };
};
