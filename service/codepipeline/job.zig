const JobData = @import("job_data.zig").JobData;

/// Represents information about a job.
pub const Job = struct {
    /// The ID of the Amazon Web Services account to use when performing the job.
    account_id: ?[]const u8,

    /// Other data about a job.
    data: ?JobData,

    /// The unique system-generated ID of the job.
    id: ?[]const u8,

    /// A system-generated random number that CodePipeline uses to ensure that the
    /// job is being worked on by only one job worker. Use this number in an
    /// AcknowledgeJob request.
    nonce: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .data = "data",
        .id = "id",
        .nonce = "nonce",
    };
};
