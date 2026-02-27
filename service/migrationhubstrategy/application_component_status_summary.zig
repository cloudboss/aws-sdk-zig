const SrcCodeOrDbAnalysisStatus = @import("src_code_or_db_analysis_status.zig").SrcCodeOrDbAnalysisStatus;

/// Summary of the analysis status of the application component.
pub const ApplicationComponentStatusSummary = struct {
    /// The number of application components successfully analyzed, partially
    /// successful or failed
    /// analysis.
    count: ?i32,

    /// The status of database analysis.
    src_code_or_db_analysis_status: ?SrcCodeOrDbAnalysisStatus,

    pub const json_field_names = .{
        .count = "count",
        .src_code_or_db_analysis_status = "srcCodeOrDbAnalysisStatus",
    };
};
