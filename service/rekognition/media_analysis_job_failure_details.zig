const MediaAnalysisJobFailureCode = @import("media_analysis_job_failure_code.zig").MediaAnalysisJobFailureCode;

/// Details about the error that resulted in failure of the job.
pub const MediaAnalysisJobFailureDetails = struct {
    /// Error code for the failed job.
    code: ?MediaAnalysisJobFailureCode = null,

    /// Human readable error message.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
