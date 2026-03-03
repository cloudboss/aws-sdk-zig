const TargetType = @import("target_type.zig").TargetType;

/// Contains information about a root, OU, or account that a policy is attached
/// to.
pub const PolicyTargetSummary = struct {
    /// The Amazon Resource Name (ARN) of the policy target.
    ///
    /// For more information about ARNs in Organizations, see [ARN
    /// Formats Supported by
    /// Organizations](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsorganizations.html#awsorganizations-resources-for-iam-policies) in the *Amazon Web Services Service Authorization Reference*.
    arn: ?[]const u8 = null,

    /// The friendly name of the policy target.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex)
    /// that is used to validate this parameter is a string of any of the characters
    /// in the ASCII
    /// character range.
    name: ?[]const u8 = null,

    /// The unique identifier (ID) of the policy target.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex) for a target ID string
    /// requires one of the
    /// following:
    ///
    /// * **Root** - A string that begins with "r-" followed by from 4 to 32
    ///   lowercase letters or
    /// digits.
    ///
    /// * **Account** - A string that consists of exactly 12 digits.
    ///
    /// * **Organizational unit (OU)** - A string that begins with "ou-" followed by
    ///   from 4 to 32
    /// lowercase letters or digits (the ID of the root that the OU is in). This
    /// string is followed by a second
    /// "-" dash and from 8 to 32 additional lowercase letters or digits.
    target_id: ?[]const u8 = null,

    /// The type of the policy target.
    @"type": ?TargetType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
        .target_id = "TargetId",
        .@"type" = "Type",
    };
};
