const JobComparator = @import("job_comparator.zig").JobComparator;
const TagCriterionPairForJob = @import("tag_criterion_pair_for_job.zig").TagCriterionPairForJob;

/// Specifies a tag-based condition that determines whether an S3 bucket is
/// included or excluded from a classification job.
pub const TagCriterionForJob = struct {
    /// The operator to use in the condition. Valid values are EQ (equals) and NE
    /// (not equals).
    comparator: ?JobComparator,

    /// The tag keys, tag values, or tag key and value pairs to use in the
    /// condition.
    tag_values: ?[]const TagCriterionPairForJob,

    pub const json_field_names = .{
        .comparator = "comparator",
        .tag_values = "tagValues",
    };
};
