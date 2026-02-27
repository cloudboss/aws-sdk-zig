const ClosedDaysRule = @import("closed_days_rule.zig").ClosedDaysRule;

/// The time when a journey will not send messages. QuietTime should be
/// configured first and SendingSchedule should be set to true.
pub const ClosedDays = struct {
    /// Rules for the Custom channel.
    custom: ?[]const ClosedDaysRule,

    /// Rules for the Email channel.
    email: ?[]const ClosedDaysRule,

    /// Rules for the Push channel.
    push: ?[]const ClosedDaysRule,

    /// Rules for the SMS channel.
    sms: ?[]const ClosedDaysRule,

    /// Rules for the Voice channel.
    voice: ?[]const ClosedDaysRule,

    pub const json_field_names = .{
        .custom = "CUSTOM",
        .email = "EMAIL",
        .push = "PUSH",
        .sms = "SMS",
        .voice = "VOICE",
    };
};
