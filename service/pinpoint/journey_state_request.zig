const State = @import("state.zig").State;

/// Changes the status of a journey.
pub const JourneyStateRequest = struct {
    /// The status of the journey. Currently, Supported values are ACTIVE, PAUSED,
    /// and CANCELLED
    ///
    /// If you cancel a journey, Amazon Pinpoint continues to perform activities
    /// that are currently in progress, until those activities are complete. Amazon
    /// Pinpoint also continues to collect and aggregate analytics data for those
    /// activities, until they are complete, and any activities that were complete
    /// when you cancelled the journey.
    ///
    /// After you cancel a journey, you can't add, change, or remove any activities
    /// from the journey. In addition, Amazon Pinpoint stops evaluating the journey
    /// and doesn't perform any activities that haven't started.
    ///
    /// When the journey is paused, Amazon Pinpoint continues to perform activities
    /// that are currently in progress, until those activities are complete.
    /// Endpoints will stop entering journeys when the journey is paused and will
    /// resume entering the journey after the journey is resumed. For wait
    /// activities, wait time is paused when the journey is paused. Currently,
    /// PAUSED only supports journeys with a segment refresh interval.
    state: ?State,

    pub const json_field_names = .{
        .state = "State",
    };
};
