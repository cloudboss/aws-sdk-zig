const JobData = @import("job_data.zig").JobData;

/// Represents information about the details of a job.
pub const JobDetails = struct {
    /// The Amazon Web Services account ID associated with the job.
    account_id: ?[]const u8 = null,

    /// Represents other information about a job required for a job worker to
    /// complete the
    /// job.
    data: ?JobData = null,

    /// The unique system-generated ID of the job.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .data = "data",
        .id = "id",
    };
};
