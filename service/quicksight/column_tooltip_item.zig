const AggregationFunction = @import("aggregation_function.zig").AggregationFunction;
const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const TooltipTarget = @import("tooltip_target.zig").TooltipTarget;
const Visibility = @import("visibility.zig").Visibility;

/// The tooltip item for the columns that are not part of a field well.
pub const ColumnTooltipItem = struct {
    /// The aggregation function of the column tooltip item.
    aggregation: ?AggregationFunction = null,

    /// The target column of the tooltip item.
    column: ColumnIdentifier,

    /// The label of the tooltip item.
    label: ?[]const u8 = null,

    /// Determines the target of the column tooltip item in a combo chart visual.
    tooltip_target: ?TooltipTarget = null,

    /// The visibility of the tooltip item.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .aggregation = "Aggregation",
        .column = "Column",
        .label = "Label",
        .tooltip_target = "TooltipTarget",
        .visibility = "Visibility",
    };
};
