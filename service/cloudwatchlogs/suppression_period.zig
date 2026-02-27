const SuppressionUnit = @import("suppression_unit.zig").SuppressionUnit;

/// If you are suppressing an anomaly temporariliy, this structure defines how
/// long the
/// suppression period is to be.
pub const SuppressionPeriod = struct {
    /// Specifies whether the value of `value` is in seconds, minutes, or hours.
    suppression_unit: ?SuppressionUnit,

    /// Specifies the number of seconds, minutes or hours to suppress this anomaly.
    /// There is no
    /// maximum.
    value: i32 = 0,

    pub const json_field_names = .{
        .suppression_unit = "suppressionUnit",
        .value = "value",
    };
};
