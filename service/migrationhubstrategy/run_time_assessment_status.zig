pub const RunTimeAssessmentStatus = enum {
    dc_to_be_scheduled,
    dc_req_sent,
    dc_started,
    dc_stopped,
    dc_success,
    dc_failed,
    dc_partial_success,

    pub const json_field_names = .{
        .dc_to_be_scheduled = "DC_TO_BE_SCHEDULED",
        .dc_req_sent = "DC_REQ_SENT",
        .dc_started = "DC_STARTED",
        .dc_stopped = "DC_STOPPED",
        .dc_success = "DC_SUCCESS",
        .dc_failed = "DC_FAILED",
        .dc_partial_success = "DC_PARTIAL_SUCCESS",
    };
};
