const Attribute = @import("attribute.zig").Attribute;

/// Contains information about an Amazon Inspector assessment template. This
/// data type is
/// used as the response element in the DescribeAssessmentTemplates
/// action.
pub const AssessmentTemplate = struct {
    /// The ARN of the assessment template.
    arn: []const u8,

    /// The number of existing assessment runs associated with this assessment
    /// template. This
    /// value can be zero or a positive integer.
    assessment_run_count: i32,

    /// The ARN of the assessment target that corresponds to this assessment
    /// template.
    assessment_target_arn: []const u8,

    /// The time at which the assessment template is created.
    created_at: i64,

    /// The duration in seconds specified for this assessment template. The default
    /// value is
    /// 3600 seconds (one hour). The maximum value is 86400 seconds (one day).
    duration_in_seconds: i32,

    /// The Amazon Resource Name (ARN) of the most recent assessment run associated
    /// with this
    /// assessment template. This value exists only when the value of
    /// assessmentRunCount is
    /// greaterpa than zero.
    last_assessment_run_arn: ?[]const u8 = null,

    /// The name of the assessment template.
    name: []const u8,

    /// The rules packages that are specified for this assessment template.
    rules_package_arns: []const []const u8,

    /// The user-defined attributes that are assigned to every generated finding
    /// from the
    /// assessment run that uses this assessment template.
    user_attributes_for_findings: []const Attribute,

    pub const json_field_names = .{
        .arn = "arn",
        .assessment_run_count = "assessmentRunCount",
        .assessment_target_arn = "assessmentTargetArn",
        .created_at = "createdAt",
        .duration_in_seconds = "durationInSeconds",
        .last_assessment_run_arn = "lastAssessmentRunArn",
        .name = "name",
        .rules_package_arns = "rulesPackageArns",
        .user_attributes_for_findings = "userAttributesForFindings",
    };
};
