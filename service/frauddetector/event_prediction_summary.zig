/// Information about the summary of an event prediction.
pub const EventPredictionSummary = struct {
    /// The detector ID.
    detector_id: ?[]const u8,

    /// The detector version ID.
    detector_version_id: ?[]const u8,

    /// The event ID.
    event_id: ?[]const u8,

    /// The timestamp of the event.
    event_timestamp: ?[]const u8,

    /// The event type.
    event_type_name: ?[]const u8,

    /// The timestamp when the prediction was generated.
    prediction_timestamp: ?[]const u8,

    pub const json_field_names = .{
        .detector_id = "detectorId",
        .detector_version_id = "detectorVersionId",
        .event_id = "eventId",
        .event_timestamp = "eventTimestamp",
        .event_type_name = "eventTypeName",
        .prediction_timestamp = "predictionTimestamp",
    };
};
