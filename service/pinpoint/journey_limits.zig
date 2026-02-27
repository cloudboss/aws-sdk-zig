const JourneyTimeframeCap = @import("journey_timeframe_cap.zig").JourneyTimeframeCap;

/// Specifies limits on the messages that a journey can send and the number of
/// times participants can enter a journey.
pub const JourneyLimits = struct {
    /// The maximum number of messages that the journey can send to a single
    /// participant during a 24-hour period. The maximum value is 100.
    daily_cap: ?i32,

    /// The maximum number of times that a participant can enter the journey. The
    /// maximum value is 100. To allow participants to enter the journey an
    /// unlimited number of times, set this value to 0.
    endpoint_reentry_cap: ?i32,

    /// Minimum time that must pass before an endpoint can re-enter a given journey.
    /// The duration should use an ISO 8601 format, such as PT1H.
    endpoint_reentry_interval: ?[]const u8,

    /// The maximum number of messages that the journey can send each second.
    messages_per_second: ?i32,

    /// The number of messages that an endpoint can receive during the specified
    /// timeframe.
    timeframe_cap: ?JourneyTimeframeCap,

    /// The maximum number of messages a journey can sent to a single endpoint. The
    /// maximum value is 100. If set to 0, this limit will not apply.
    total_cap: ?i32,

    pub const json_field_names = .{
        .daily_cap = "DailyCap",
        .endpoint_reentry_cap = "EndpointReentryCap",
        .endpoint_reentry_interval = "EndpointReentryInterval",
        .messages_per_second = "MessagesPerSecond",
        .timeframe_cap = "TimeframeCap",
        .total_cap = "TotalCap",
    };
};
