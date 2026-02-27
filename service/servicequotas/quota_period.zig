const PeriodUnit = @import("period_unit.zig").PeriodUnit;

/// Information about the quota period.
pub const QuotaPeriod = struct {
    /// The time unit.
    period_unit: ?PeriodUnit,

    /// The value associated with the reported `PeriodUnit`.
    period_value: ?i32,

    pub const json_field_names = .{
        .period_unit = "PeriodUnit",
        .period_value = "PeriodValue",
    };
};
