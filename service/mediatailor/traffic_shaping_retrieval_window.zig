/// The configuration that tells Elemental MediaTailor how many seconds to
/// spread out requests to the ad decision server (ADS). Instead of sending ADS
/// requests for all sessions at the same time, MediaTailor spreads the requests
/// across the amount of time specified in the retrieval window.
pub const TrafficShapingRetrievalWindow = struct {
    /// The amount of time, in seconds, that MediaTailor spreads prefetch requests
    /// to the ADS.
    retrieval_window_duration_seconds: ?i32,

    pub const json_field_names = .{
        .retrieval_window_duration_seconds = "RetrievalWindowDurationSeconds",
    };
};
