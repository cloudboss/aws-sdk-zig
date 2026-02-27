const SimpleCriterionForJob = @import("simple_criterion_for_job.zig").SimpleCriterionForJob;
const TagCriterionForJob = @import("tag_criterion_for_job.zig").TagCriterionForJob;

/// Specifies a property- or tag-based condition that defines criteria for
/// including or excluding S3 buckets from a classification job.
pub const CriteriaForJob = struct {
    /// A property-based condition that defines a property, operator, and one or
    /// more values for including or excluding buckets from the job.
    simple_criterion: ?SimpleCriterionForJob,

    /// A tag-based condition that defines an operator and tag keys, tag values, or
    /// tag key and value pairs for including or excluding buckets from the job.
    tag_criterion: ?TagCriterionForJob,

    pub const json_field_names = .{
        .simple_criterion = "simpleCriterion",
        .tag_criterion = "tagCriterion",
    };
};
