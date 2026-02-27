const ThirdPartyJobData = @import("third_party_job_data.zig").ThirdPartyJobData;

/// The details of a job sent in response to a `GetThirdPartyJobDetails`
/// request.
pub const ThirdPartyJobDetails = struct {
    /// The data to be returned by the third party job worker.
    data: ?ThirdPartyJobData,

    /// The identifier used to identify the job details in CodePipeline.
    id: ?[]const u8,

    /// A system-generated random number that CodePipeline uses to ensure that the
    /// job is being worked on by only one job worker. Use this number in an
    /// AcknowledgeThirdPartyJob request.
    nonce: ?[]const u8,

    pub const json_field_names = .{
        .data = "data",
        .id = "id",
        .nonce = "nonce",
    };
};
