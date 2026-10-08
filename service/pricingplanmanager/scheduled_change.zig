const ScheduledChangeType = @import("scheduled_change_type.zig").ScheduledChangeType;

/// A pending change on a subscription that takes effect at the end of the
/// current billing period, such as a tier downgrade or cancellation.
pub const ScheduledChange = struct {
    /// The type of pending change. Possible values are `DOWNGRADE` (a tier change
    /// to a lower level) and `CANCELLATION` (subscription termination).
    change_type: ScheduledChangeType,

    /// The date and time when the change takes effect, in ISO 8601 format. This
    /// value is populated after the change is confirmed by the billing system.
    effective_date: ?i64 = null,

    /// For downgrades, the tier level that the subscription will change to. Not
    /// present for cancellations.
    plan_tier: ?[]const u8 = null,

    /// For downgrades, the target usage level after the change takes effect.
    usage_level: ?[]const u8 = null,

    pub const json_field_names = .{
        .change_type = "changeType",
        .effective_date = "effectiveDate",
        .plan_tier = "planTier",
        .usage_level = "usageLevel",
    };
};
