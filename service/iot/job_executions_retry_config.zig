const RetryCriteria = @import("retry_criteria.zig").RetryCriteria;

/// The configuration that determines how many retries are allowed for each
/// failure type
/// for a job.
pub const JobExecutionsRetryConfig = struct {
    /// The list of criteria that determines how many retries are allowed for each
    /// failure
    /// type for a job.
    criteria_list: []const RetryCriteria,

    pub const json_field_names = .{
        .criteria_list = "criteriaList",
    };
};
