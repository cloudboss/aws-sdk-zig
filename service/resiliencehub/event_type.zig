pub const EventType = enum {
    scheduled_assessment_failure,
    drift_detected,

    pub const json_field_names = .{
        .scheduled_assessment_failure = "SCHEDULED_ASSESSMENT_FAILURE",
        .drift_detected = "DRIFT_DETECTED",
    };
};
