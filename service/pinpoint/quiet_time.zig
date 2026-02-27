/// Specifies the start and end times that define a time range when messages
/// aren't sent to endpoints.
pub const QuietTime = struct {
    /// The specific time when quiet time ends. This value has to use 24-hour
    /// notation and be in HH:MM format, where HH is the hour (with a leading zero,
    /// if applicable) and MM is the minutes. For example, use 02:30 to represent
    /// 2:30 AM, or 14:30 to represent 2:30 PM.
    end: ?[]const u8,

    /// The specific time when quiet time begins. This value has to use 24-hour
    /// notation and be in HH:MM format, where HH is the hour (with a leading zero,
    /// if applicable) and MM is the minutes. For example, use 02:30 to represent
    /// 2:30 AM, or 14:30 to represent 2:30 PM.
    start: ?[]const u8,

    pub const json_field_names = .{
        .end = "End",
        .start = "Start",
    };
};
