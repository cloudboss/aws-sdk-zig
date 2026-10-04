/// A time-bound restriction on a calling action, such as the number of calls
/// allowed within a time period.
pub const WhatsAppCallPermissionLimit = struct {
    /// The number of times the action has been used within the current time period.
    current_usage: i32,

    /// The time when the limit resets. This value is present only when the current
    /// usage has reached the maximum allowed.
    limit_expiration_time: ?i64 = null,

    /// The maximum number of times the action is allowed within the time period.
    max_allowed: i32,

    /// The time period over which the limit applies, as an ISO 8601 duration.
    time_period: []const u8,

    pub const json_field_names = .{
        .current_usage = "currentUsage",
        .limit_expiration_time = "limitExpirationTime",
        .max_allowed = "maxAllowed",
        .time_period = "timePeriod",
    };
};
