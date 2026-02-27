const aws = @import("aws");

const OpenHoursRule = @import("open_hours_rule.zig").OpenHoursRule;

/// Specifies the times when message are allowed to be sent to endpoints.
pub const OpenHours = struct {
    /// Specifies the schedule settings for the custom channel.
    custom: ?[]const aws.map.MapEntry([]const OpenHoursRule),

    /// Specifies the schedule settings for the email channel.
    email: ?[]const aws.map.MapEntry([]const OpenHoursRule),

    /// Specifies the schedule settings for the push channel.
    push: ?[]const aws.map.MapEntry([]const OpenHoursRule),

    /// Specifies the schedule settings for the SMS channel.
    sms: ?[]const aws.map.MapEntry([]const OpenHoursRule),

    /// Specifies the schedule settings for the voice channel.
    voice: ?[]const aws.map.MapEntry([]const OpenHoursRule),

    pub const json_field_names = .{
        .custom = "CUSTOM",
        .email = "EMAIL",
        .push = "PUSH",
        .sms = "SMS",
        .voice = "VOICE",
    };
};
