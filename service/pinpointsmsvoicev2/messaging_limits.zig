const aws = @import("aws");

/// The messaging limits that apply to an origination identity, such as a phone
/// number, sender ID, or RCS agent. Includes the per-capability send rates and,
/// for supported origination identities, advisory per-provider daily message
/// caps.
pub const MessagingLimits = struct {
    /// The advisory maximum number of messages that can be sent per day, keyed by
    /// provider (for example, `T-MOBILE`). Applies to 10DLC phone numbers and is
    /// omitted when no daily cap applies.
    daily_message_caps: ?[]const aws.map.MapEntry(i64) = null,

    /// The maximum send rate for each supported capability, in messages per second.
    /// The map is keyed by capability, such as `SMS`, `MMS`, `VOICE`, or `RCS`.
    rate_limits: ?[]const aws.map.MapEntry(i64) = null,

    pub const json_field_names = .{
        .daily_message_caps = "DailyMessageCaps",
        .rate_limits = "RateLimits",
    };
};
