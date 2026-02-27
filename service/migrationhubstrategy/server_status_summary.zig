const RunTimeAssessmentStatus = @import("run_time_assessment_status.zig").RunTimeAssessmentStatus;

/// The status summary of the server analysis.
pub const ServerStatusSummary = struct {
    /// The number of servers successfully analyzed, partially successful or failed
    /// analysis.
    count: ?i32,

    /// The status of the run time.
    run_time_assessment_status: ?RunTimeAssessmentStatus,

    pub const json_field_names = .{
        .count = "count",
        .run_time_assessment_status = "runTimeAssessmentStatus",
    };
};
