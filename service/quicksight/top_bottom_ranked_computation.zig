const DimensionField = @import("dimension_field.zig").DimensionField;
const TopBottomComputationType = @import("top_bottom_computation_type.zig").TopBottomComputationType;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The top ranked and bottom ranked computation configuration.
pub const TopBottomRankedComputation = struct {
    /// The category field that is used in a computation.
    category: ?DimensionField = null,

    /// The ID for a computation.
    computation_id: []const u8,

    /// The name of a computation.
    name: ?[]const u8 = null,

    /// The result size of a top and bottom ranked computation.
    result_size: ?i32 = null,

    /// The computation type. Choose one of the following options:
    ///
    /// * TOP: A top ranked computation.
    ///
    /// * BOTTOM: A bottom ranked computation.
    @"type": TopBottomComputationType,

    /// The value field that is used in a computation.
    value: ?MeasureField = null,

    pub const json_field_names = .{
        .category = "Category",
        .computation_id = "ComputationId",
        .name = "Name",
        .result_size = "ResultSize",
        .@"type" = "Type",
        .value = "Value",
    };
};
