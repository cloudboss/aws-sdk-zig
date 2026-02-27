pub const InspectorEvent = enum {
    assessment_run_started,
    assessment_run_completed,
    assessment_run_state_changed,
    finding_reported,
    other,

    pub const json_field_names = .{
        .assessment_run_started = "ASSESSMENT_RUN_STARTED",
        .assessment_run_completed = "ASSESSMENT_RUN_COMPLETED",
        .assessment_run_state_changed = "ASSESSMENT_RUN_STATE_CHANGED",
        .finding_reported = "FINDING_REPORTED",
        .other = "OTHER",
    };
};
