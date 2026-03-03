const CriteriaForJob = @import("criteria_for_job.zig").CriteriaForJob;

/// Specifies one or more property- and tag-based conditions that define
/// criteria for including or excluding S3 buckets from a classification job.
pub const CriteriaBlockForJob = struct {
    /// An array of conditions, one for each condition that determines which buckets
    /// to include or exclude from the job. If you specify more than one condition,
    /// Amazon Macie uses AND logic to join the conditions.
    @"and": ?[]const CriteriaForJob = null,

    pub const json_field_names = .{
        .@"and" = "and",
    };
};
