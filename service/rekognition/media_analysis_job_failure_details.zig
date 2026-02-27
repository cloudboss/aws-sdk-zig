const MediaAnalysisJobFailureCode = @import("media_analysis_job_failure_code.zig").MediaAnalysisJobFailureCode;

/// Details about the error that resulted in failure of the job.
pub const MediaAnalysisJobFailureDetails = struct {
    /// Error code for the failed job.
    code: ?MediaAnalysisJobFailureCode,

    /// Human readable error message.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
