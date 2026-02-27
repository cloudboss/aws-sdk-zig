/// Contains information about an Identity and Access Management role. For more
/// information, see [IAM
/// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html) in
/// the
/// *IAM User Guide*.
pub const IAMRoleIdentity = struct {
    /// The ARN of the IAM role. For more information, see [IAM
    /// ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html) in the
    /// *IAM User Guide*.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
