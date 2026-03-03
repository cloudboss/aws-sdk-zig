const DayOfWeek = @import("day_of_week.zig").DayOfWeek;
const AuditFrequency = @import("audit_frequency.zig").AuditFrequency;

/// Information about the scheduled audit.
pub const ScheduledAuditMetadata = struct {
    /// The day of the month on which the scheduled audit is run (if the
    /// `frequency` is "MONTHLY").
    /// If days 29-31 are specified, and the month does not have that many
    /// days, the audit takes place on the "LAST" day of the month.
    day_of_month: ?[]const u8 = null,

    /// The day of the week on which the scheduled audit is run (if the
    /// `frequency` is "WEEKLY" or "BIWEEKLY").
    day_of_week: ?DayOfWeek = null,

    /// How often the scheduled audit occurs.
    frequency: ?AuditFrequency = null,

    /// The ARN of the scheduled audit.
    scheduled_audit_arn: ?[]const u8 = null,

    /// The name of the scheduled audit.
    scheduled_audit_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .day_of_month = "dayOfMonth",
        .day_of_week = "dayOfWeek",
        .frequency = "frequency",
        .scheduled_audit_arn = "scheduledAuditArn",
        .scheduled_audit_name = "scheduledAuditName",
    };
};
