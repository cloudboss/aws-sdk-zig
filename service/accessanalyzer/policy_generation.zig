const JobStatus = @import("job_status.zig").JobStatus;

/// Contains details about the policy generation status and properties.
pub const PolicyGeneration = struct {
    /// A timestamp of when the policy generation was completed.
    completed_on: ?i64,

    /// The `JobId` that is returned by the `StartPolicyGeneration` operation. The
    /// `JobId` can be used with `GetGeneratedPolicy` to retrieve the generated
    /// policies or used with `CancelPolicyGeneration` to cancel the policy
    /// generation request.
    job_id: []const u8,

    /// The ARN of the IAM entity (user or role) for which you are generating a
    /// policy.
    principal_arn: []const u8,

    /// A timestamp of when the policy generation started.
    started_on: i64,

    /// The status of the policy generation request.
    status: JobStatus,

    pub const json_field_names = .{
        .completed_on = "completedOn",
        .job_id = "jobId",
        .principal_arn = "principalArn",
        .started_on = "startedOn",
        .status = "status",
    };
};
