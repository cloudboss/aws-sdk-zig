const IntegerCriteriaCondition = @import("integer_criteria_condition.zig").IntegerCriteriaCondition;
const StringCriteriaCondition = @import("string_criteria_condition.zig").StringCriteriaCondition;
const DoubleCriteriaCondition = @import("double_criteria_condition.zig").DoubleCriteriaCondition;
const ResourceTagsCriteriaCondition = @import("resource_tags_criteria_condition.zig").ResourceTagsCriteriaCondition;

/// A set of conditions that specify which recommended action qualify for
/// implementation. When a rule is active and a recommended action matches these
/// criteria, Compute Optimizer implements the action at the scheduled run time.
/// You can specify up to 20 conditions per filter criteria and 20 values per
/// condition.
pub const Criteria = struct {
    /// Filter criteria for EBS volume sizes in gibibytes (GiB).
    ebs_volume_size_in_gib: ?[]const IntegerCriteriaCondition,

    /// Filter criteria for EBS volume types, such as gp2, gp3, io1, io2, st1, or
    /// sc1.
    ebs_volume_type: ?[]const StringCriteriaCondition,

    /// Filter criteria for estimated monthly cost savings from the recommended
    /// action.
    estimated_monthly_savings: ?[]const DoubleCriteriaCondition,

    /// Filter criteria for the lookback period in days used to analyze resource
    /// utilization.
    look_back_period_in_days: ?[]const IntegerCriteriaCondition,

    /// Filter criteria for Amazon Web Services regions where resources must be
    /// located.
    region: ?[]const StringCriteriaCondition,

    /// Filter criteria for specific resource ARNs to include or exclude.
    resource_arn: ?[]const StringCriteriaCondition,

    /// Filter criteria for resource tags, allowing filtering by tag key and value
    /// combinations.
    resource_tag: ?[]const ResourceTagsCriteriaCondition,

    /// Filter criteria indicating whether the recommended action requires a
    /// resource restart.
    restart_needed: ?[]const StringCriteriaCondition,

    pub const json_field_names = .{
        .ebs_volume_size_in_gib = "ebsVolumeSizeInGib",
        .ebs_volume_type = "ebsVolumeType",
        .estimated_monthly_savings = "estimatedMonthlySavings",
        .look_back_period_in_days = "lookBackPeriodInDays",
        .region = "region",
        .resource_arn = "resourceArn",
        .resource_tag = "resourceTag",
        .restart_needed = "restartNeeded",
    };
};
