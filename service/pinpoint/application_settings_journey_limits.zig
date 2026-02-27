const JourneyTimeframeCap = @import("journey_timeframe_cap.zig").JourneyTimeframeCap;

/// The default sending limits for journeys in the application. To override
/// these limits and define custom limits for a specific journey, use the
/// Journey resource.
pub const ApplicationSettingsJourneyLimits = struct {
    /// The daily number of messages that an endpoint can receive from all journeys.
    /// The maximum value is 100. If set to 0, this limit will not apply.
    daily_cap: ?i32,

    /// The default maximum number of messages that can be sent to an endpoint
    /// during the specified timeframe for all journeys.
    timeframe_cap: ?JourneyTimeframeCap,

    /// The default maximum number of messages that a single journey can sent to a
    /// single endpoint. The maximum value is 100. If set to 0, this limit will not
    /// apply.
    total_cap: ?i32,

    pub const json_field_names = .{
        .daily_cap = "DailyCap",
        .timeframe_cap = "TimeframeCap",
        .total_cap = "TotalCap",
    };
};
