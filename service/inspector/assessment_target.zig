/// Contains information about an Amazon Inspector application. This data type
/// is used as
/// the response element in the DescribeAssessmentTargets action.
pub const AssessmentTarget = struct {
    /// The ARN that specifies the Amazon Inspector assessment target.
    arn: []const u8,

    /// The time at which the assessment target is created.
    created_at: i64,

    /// The name of the Amazon Inspector assessment target.
    name: []const u8,

    /// The ARN that specifies the resource group that is associated with the
    /// assessment
    /// target.
    resource_group_arn: ?[]const u8 = null,

    /// The time at which UpdateAssessmentTarget is called.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .name = "name",
        .resource_group_arn = "resourceGroupArn",
        .updated_at = "updatedAt",
    };
};
