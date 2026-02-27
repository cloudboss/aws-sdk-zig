const PolicyType = @import("policy_type.zig").PolicyType;

/// Contains information about a policy, but does not include the content. To
/// see the
/// content of a policy, see DescribePolicy.
pub const PolicySummary = struct {
    /// The Amazon Resource Name (ARN) of the policy.
    ///
    /// For more information about ARNs in Organizations, see [ARN
    /// Formats Supported by
    /// Organizations](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsorganizations.html#awsorganizations-resources-for-iam-policies) in the *Amazon Web Services Service Authorization Reference*.
    arn: ?[]const u8,

    /// A boolean value that indicates whether the specified policy is an Amazon Web
    /// Services managed
    /// policy. If true, then you can attach the policy to roots, OUs, or accounts,
    /// but you
    /// cannot edit it.
    aws_managed: bool = false,

    /// The description of the policy.
    description: ?[]const u8,

    /// The unique identifier (ID) of the policy.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for a policy ID string
    /// requires "p-" followed
    /// by from 8 to 128 lowercase or uppercase letters, digits, or the underscore
    /// character (_).
    id: ?[]const u8,

    /// The friendly name of the policy.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex)
    /// that is used to validate this parameter is a string of any of the characters
    /// in the ASCII
    /// character range.
    name: ?[]const u8,

    /// The type of policy.
    type: ?PolicyType,

    pub const json_field_names = .{
        .arn = "Arn",
        .aws_managed = "AwsManaged",
        .description = "Description",
        .id = "Id",
        .name = "Name",
        .type = "Type",
    };
};
