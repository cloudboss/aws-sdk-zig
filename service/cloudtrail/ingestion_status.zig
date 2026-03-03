/// A table showing information about the most recent successful and failed
/// attempts
/// to ingest events.
pub const IngestionStatus = struct {
    /// The event ID of the most recent attempt to ingest events.
    latest_ingestion_attempt_event_id: ?[]const u8 = null,

    /// The time stamp of the most recent attempt to ingest events on the channel.
    latest_ingestion_attempt_time: ?i64 = null,

    /// The error code for the most recent failure to ingest events.
    latest_ingestion_error_code: ?[]const u8 = null,

    /// The event ID of the most recent successful ingestion of events.
    latest_ingestion_success_event_id: ?[]const u8 = null,

    /// The time stamp of the most recent successful ingestion of events for the
    /// channel.
    latest_ingestion_success_time: ?i64 = null,

    pub const json_field_names = .{
        .latest_ingestion_attempt_event_id = "LatestIngestionAttemptEventID",
        .latest_ingestion_attempt_time = "LatestIngestionAttemptTime",
        .latest_ingestion_error_code = "LatestIngestionErrorCode",
        .latest_ingestion_success_event_id = "LatestIngestionSuccessEventID",
        .latest_ingestion_success_time = "LatestIngestionSuccessTime",
    };
};
