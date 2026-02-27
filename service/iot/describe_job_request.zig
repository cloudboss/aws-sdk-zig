pub const DescribeJobRequest = struct {
    /// Provides a view of the job document before and after the substitution
    /// parameters have been resolved with their exact values.
    before_substitution: bool = false,

    /// The unique identifier you assigned to this job when it was created.
    job_id: []const u8,

    pub const json_field_names = .{
        .before_substitution = "beforeSubstitution",
        .job_id = "jobId",
    };
};
