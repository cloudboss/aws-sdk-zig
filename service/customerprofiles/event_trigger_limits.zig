const Period = @import("period.zig").Period;

/// Defines limits controlling whether an event triggers the destination, based
/// on ingestion
/// latency and the number of invocations per profile over specific time
/// periods.
pub const EventTriggerLimits = struct {
    /// In milliseconds. Specifies that an event will only trigger the destination
    /// if it is
    /// processed within a certain latency period.
    event_expiration: ?i64 = null,

    /// A list of time periods during which the limits apply.
    periods: ?[]const Period = null,

    pub const json_field_names = .{
        .event_expiration = "EventExpiration",
        .periods = "Periods",
    };
};
