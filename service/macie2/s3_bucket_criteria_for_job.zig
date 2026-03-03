const CriteriaBlockForJob = @import("criteria_block_for_job.zig").CriteriaBlockForJob;

/// Specifies property- and tag-based conditions that define criteria for
/// including or excluding S3 buckets from a classification job. Exclude
/// conditions take precedence over include conditions.
pub const S3BucketCriteriaForJob = struct {
    /// The property- and tag-based conditions that determine which buckets to
    /// exclude from the job.
    excludes: ?CriteriaBlockForJob = null,

    /// The property- and tag-based conditions that determine which buckets to
    /// include in the job.
    includes: ?CriteriaBlockForJob = null,

    pub const json_field_names = .{
        .excludes = "excludes",
        .includes = "includes",
    };
};
