/// Represents the metadata of a memory extraction job such as the message
/// identifiers that compose this job.
pub const ExtractionJob = struct {
    /// The unique identifier of the extraction job.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
    };
};
