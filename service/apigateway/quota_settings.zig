const QuotaPeriodType = @import("quota_period_type.zig").QuotaPeriodType;

/// Quotas configured for a usage plan.
pub const QuotaSettings = struct {
    /// The target maximum number of requests that can be made in a given time
    /// period.
    limit: i32 = 0,

    /// The number of requests subtracted from the given limit in the initial time
    /// period.
    offset: i32 = 0,

    /// The time period in which the limit applies. Valid values are "DAY", "WEEK"
    /// or "MONTH".
    period: ?QuotaPeriodType,

    pub const json_field_names = .{
        .limit = "limit",
        .offset = "offset",
        .period = "period",
    };
};
