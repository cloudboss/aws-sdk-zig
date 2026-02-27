/// Provides the details of the `MarkerRecorded` event.
pub const MarkerRecordedEventAttributes = struct {
    /// The ID of the `DecisionTaskCompleted` event corresponding to the decision
    /// task that resulted in the
    /// `RecordMarker` decision that requested this marker. This information can be
    /// useful for diagnosing problems by tracing back the chain of
    /// events leading up to this event.
    decision_task_completed_event_id: i64 = 0,

    /// The details of the marker.
    details: ?[]const u8,

    /// The name of the marker.
    marker_name: []const u8,

    pub const json_field_names = .{
        .decision_task_completed_event_id = "decisionTaskCompletedEventId",
        .details = "details",
        .marker_name = "markerName",
    };
};
