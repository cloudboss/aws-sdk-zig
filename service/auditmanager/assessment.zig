const aws = @import("aws");

const AWSAccount = @import("aws_account.zig").AWSAccount;
const AssessmentFramework = @import("assessment_framework.zig").AssessmentFramework;
const AssessmentMetadata = @import("assessment_metadata.zig").AssessmentMetadata;

/// An entity that defines the scope of audit evidence collected by Audit
/// Manager.
/// An Audit Manager assessment is an implementation of an Audit Manager
/// framework.
pub const Assessment = struct {
    /// The Amazon Resource Name (ARN) of the assessment.
    arn: ?[]const u8 = null,

    /// The Amazon Web Services account that's associated with the assessment.
    aws_account: ?AWSAccount = null,

    /// The framework that the assessment was created from.
    framework: ?AssessmentFramework = null,

    /// The metadata for the assessment.
    metadata: ?AssessmentMetadata = null,

    /// The tags that are associated with the assessment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .aws_account = "awsAccount",
        .framework = "framework",
        .metadata = "metadata",
        .tags = "tags",
    };
};
