/// Provides details about a predictor event, such as a retraining.
pub const PredictorEvent = struct {
    /// The timestamp for when the event occurred.
    datetime: ?i64,

    /// The type of event. For example, `Retrain`. A retraining event denotes the
    /// timepoint when a predictor was retrained. Any monitor results from before
    /// the `Datetime` are from the previous predictor. Any new metrics are for the
    /// newly retrained predictor.
    detail: ?[]const u8,

    pub const json_field_names = .{
        .datetime = "Datetime",
        .detail = "Detail",
    };
};
