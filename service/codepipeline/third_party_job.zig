/// A response to a `PollForThirdPartyJobs` request returned by CodePipeline
/// when there is a job to be worked on by a partner action.
pub const ThirdPartyJob = struct {
    /// The `clientToken` portion of the `clientId` and
    /// `clientToken` pair used to verify that the calling entity is allowed
    /// access to the job and its details.
    client_id: ?[]const u8 = null,

    /// The identifier used to identify the job in CodePipeline.
    job_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_id = "clientId",
        .job_id = "jobId",
    };
};
