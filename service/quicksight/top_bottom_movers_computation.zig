const DimensionField = @import("dimension_field.zig").DimensionField;
const TopBottomSortOrder = @import("top_bottom_sort_order.zig").TopBottomSortOrder;
const TopBottomComputationType = @import("top_bottom_computation_type.zig").TopBottomComputationType;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The top movers and bottom movers computation setup.
pub const TopBottomMoversComputation = struct {
    /// The category field that is used in a computation.
    category: ?DimensionField = null,

    /// The ID for a computation.
    computation_id: []const u8,

    /// The mover size setup of the top and bottom movers computation.
    mover_size: ?i32 = null,

    /// The name of a computation.
    name: ?[]const u8 = null,

    /// The sort order setup of the top and bottom movers computation.
    sort_order: ?TopBottomSortOrder = null,

    /// The time field that is used in a computation.
    time: ?DimensionField = null,

    /// The computation type. Choose from the following options:
    ///
    /// * TOP: Top movers computation.
    ///
    /// * BOTTOM: Bottom movers computation.
    @"type": TopBottomComputationType,

    /// The value field that is used in a computation.
    value: ?MeasureField = null,

    pub const json_field_names = .{
        .category = "Category",
        .computation_id = "ComputationId",
        .mover_size = "MoverSize",
        .name = "Name",
        .sort_order = "SortOrder",
        .time = "Time",
        .@"type" = "Type",
        .value = "Value",
    };
};
