const AggregationSortConfiguration = @import("aggregation_sort_configuration.zig").AggregationSortConfiguration;
const SelectableValuesSort = @import("selectable_values_sort.zig").SelectableValuesSort;

/// The sort configuration for control values. This is a tagged union type.
/// Specify either `SelectableValuesSort` or `ControlColumnSort`, but not both.
pub const ControlSortConfiguration = struct {
    /// The sort configuration for controls that are tied to a dataset column. Use
    /// this option to sort control values by an aggregate of a column.
    control_column_sort: ?AggregationSortConfiguration = null,

    /// The sort configuration for user-specified values in the control. Use this
    /// option to sort values that are manually entered by users in a dropdown or
    /// list control.
    selectable_values_sort: ?SelectableValuesSort = null,

    pub const json_field_names = .{
        .control_column_sort = "ControlColumnSort",
        .selectable_values_sort = "SelectableValuesSort",
    };
};
