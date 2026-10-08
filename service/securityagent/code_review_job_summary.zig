const JobStatus = @import("job_status.zig").JobStatus;

/// Contains summary information about a code review job.
pub const CodeReviewJobSummary = struct {
    /// The unique identifier of the code review associated with the job.
    code_review_id: []const u8,

    /// The unique identifier of the code review job.
    code_review_job_id: []const u8,

    /// The date and time the code review job was created, in UTC format.
    created_at: ?i64 = null,

    /// The current status of the code review job.
    status: ?JobStatus = null,

    /// The title of the code review job.
    title: ?[]const u8 = null,

    /// The date and time the code review job was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .code_review_id = "codeReviewId",
        .code_review_job_id = "codeReviewJobId",
        .created_at = "createdAt",
        .status = "status",
        .title = "title",
        .updated_at = "updatedAt",
    };
};
