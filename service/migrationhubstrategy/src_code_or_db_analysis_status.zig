pub const SrcCodeOrDbAnalysisStatus = enum {
    analysis_to_be_scheduled,
    analysis_started,
    analysis_success,
    analysis_failed,
    analysis_partial_success,
    unconfigured,
    configured,

    pub const json_field_names = .{
        .analysis_to_be_scheduled = "ANALYSIS_TO_BE_SCHEDULED",
        .analysis_started = "ANALYSIS_STARTED",
        .analysis_success = "ANALYSIS_SUCCESS",
        .analysis_failed = "ANALYSIS_FAILED",
        .analysis_partial_success = "ANALYSIS_PARTIAL_SUCCESS",
        .unconfigured = "UNCONFIGURED",
        .configured = "CONFIGURED",
    };
};
