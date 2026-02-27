const AnalysisStatus = @import("analysis_status.zig").AnalysisStatus;
const CommitmentPurchaseAnalysisConfiguration = @import("commitment_purchase_analysis_configuration.zig").CommitmentPurchaseAnalysisConfiguration;
const ErrorCode = @import("error_code.zig").ErrorCode;

/// A summary of the analysis.
pub const AnalysisSummary = struct {
    /// The completion time of the analysis.
    analysis_completion_time: ?[]const u8,

    /// The analysis ID that's associated with the commitment purchase analysis.
    analysis_id: ?[]const u8,

    /// The start time of the analysis.
    analysis_started_time: ?[]const u8,

    /// The status of the analysis.
    analysis_status: ?AnalysisStatus,

    /// The configuration for the commitment purchase analysis.
    commitment_purchase_analysis_configuration: ?CommitmentPurchaseAnalysisConfiguration,

    /// The error code used for the analysis.
    error_code: ?ErrorCode,

    /// The estimated time for when the analysis will complete.
    estimated_completion_time: ?[]const u8,

    pub const json_field_names = .{
        .analysis_completion_time = "AnalysisCompletionTime",
        .analysis_id = "AnalysisId",
        .analysis_started_time = "AnalysisStartedTime",
        .analysis_status = "AnalysisStatus",
        .commitment_purchase_analysis_configuration = "CommitmentPurchaseAnalysisConfiguration",
        .error_code = "ErrorCode",
        .estimated_completion_time = "EstimatedCompletionTime",
    };
};
