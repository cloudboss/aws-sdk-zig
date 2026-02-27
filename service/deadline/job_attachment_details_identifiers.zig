/// Identifier details for job attachments.
pub const JobAttachmentDetailsIdentifiers = struct {
    /// The job ID.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
    };
};
