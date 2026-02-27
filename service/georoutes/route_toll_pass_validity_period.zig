const RouteTollPassValidityPeriodType = @import("route_toll_pass_validity_period_type.zig").RouteTollPassValidityPeriodType;

/// Period for which the pass is valid.
pub const RouteTollPassValidityPeriod = struct {
    /// Validity period.
    period: RouteTollPassValidityPeriodType,

    /// Counts for the validity period.
    period_count: ?i32,

    pub const json_field_names = .{
        .period = "Period",
        .period_count = "PeriodCount",
    };
};
