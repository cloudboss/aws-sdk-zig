pub const SelfManagedCaseStatus = enum {
    submitted,
    detection_and_analysis,
    containment_eradication_and_recovery,
    post_incident_activities,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .detection_and_analysis = "DETECTION_AND_ANALYSIS",
        .containment_eradication_and_recovery = "CONTAINMENT_ERADICATION_AND_RECOVERY",
        .post_incident_activities = "POST_INCIDENT_ACTIVITIES",
    };
};
