pub const CaseStatus = enum {
    submitted,
    acknowledged,
    detection_and_analysis,
    containment_eradication_and_recovery,
    post_incident_activities,
    ready_to_close,
    closed,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .acknowledged = "ACKNOWLEDGED",
        .detection_and_analysis = "DETECTION_AND_ANALYSIS",
        .containment_eradication_and_recovery = "CONTAINMENT_ERADICATION_AND_RECOVERY",
        .post_incident_activities = "POST_INCIDENT_ACTIVITIES",
        .ready_to_close = "READY_TO_CLOSE",
        .closed = "CLOSED",
    };
};
