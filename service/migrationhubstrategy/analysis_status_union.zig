const RuntimeAnalysisStatus = @import("runtime_analysis_status.zig").RuntimeAnalysisStatus;
const SrcCodeOrDbAnalysisStatus = @import("src_code_or_db_analysis_status.zig").SrcCodeOrDbAnalysisStatus;

/// A combination of existing analysis statuses.
pub const AnalysisStatusUnion = union(enum) {
    /// The status of the analysis.
    runtime_analysis_status: ?RuntimeAnalysisStatus,
    /// The status of the source code or database analysis.
    src_code_or_db_analysis_status: ?SrcCodeOrDbAnalysisStatus,

    pub const json_field_names = .{
        .runtime_analysis_status = "runtimeAnalysisStatus",
        .src_code_or_db_analysis_status = "srcCodeOrDbAnalysisStatus",
    };
};
