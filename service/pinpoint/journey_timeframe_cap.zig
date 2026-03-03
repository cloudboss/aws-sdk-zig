/// The number of messages that can be sent to an endpoint during the specified
/// timeframe for all journeys.
pub const JourneyTimeframeCap = struct {
    /// The maximum number of messages that all journeys can send to an endpoint
    /// during the specified timeframe. The maximum value is 100. If set to 0, this
    /// limit will not apply.
    cap: ?i32 = null,

    /// The length of the timeframe in days. The maximum value is 30. If set to 0,
    /// this limit will not apply.
    days: ?i32 = null,

    pub const json_field_names = .{
        .cap = "Cap",
        .days = "Days",
    };
};
