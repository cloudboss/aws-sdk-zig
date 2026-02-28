const ThresholdType = @import("threshold_type.zig").ThresholdType;
const ThresholdUnit = @import("threshold_unit.zig").ThresholdUnit;

/// The threshold used with a non-aggregate check expression. The non-aggregate
/// check expression
/// will be applied to each row in a specific column. Then the threshold will be
/// used to determine
/// whether the validation succeeds.
pub const Threshold = struct {
    /// The type of a threshold. Used for comparison of an actual count of rows that
    /// satisfy the
    /// rule to the threshold value.
    @"type": ?ThresholdType,

    /// Unit of threshold value. Can be either a COUNT or PERCENTAGE of the full
    /// sample size
    /// used for validation.
    unit: ?ThresholdUnit,

    /// The value of a threshold.
    value: f64 = 0,

    pub const json_field_names = .{
        .@"type" = "Type",
        .unit = "Unit",
        .value = "Value",
    };
};
