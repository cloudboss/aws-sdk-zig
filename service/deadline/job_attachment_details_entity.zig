const Attachments = @import("attachments.zig").Attachments;

/// The job attachments.
pub const JobAttachmentDetailsEntity = struct {
    /// The job attachments.
    attachments: Attachments,

    /// The job ID.
    job_id: []const u8,

    pub const json_field_names = .{
        .attachments = "attachments",
        .job_id = "jobId",
    };
};
