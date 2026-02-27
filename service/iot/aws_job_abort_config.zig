const AwsJobAbortCriteria = @import("aws_job_abort_criteria.zig").AwsJobAbortCriteria;

/// The criteria that determine when and how a job abort takes place.
pub const AwsJobAbortConfig = struct {
    /// The list of criteria that determine when and how to abort the job.
    abort_criteria_list: []const AwsJobAbortCriteria,

    pub const json_field_names = .{
        .abort_criteria_list = "abortCriteriaList",
    };
};
