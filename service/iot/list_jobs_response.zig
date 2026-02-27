const JobSummary = @import("job_summary.zig").JobSummary;

pub const ListJobsResponse = struct {
    /// A list of jobs.
    jobs: ?[]const JobSummary,

    /// The token for the next set of results, or **null** if
    /// there are no additional results.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .jobs = "jobs",
        .next_token = "nextToken",
    };
};
