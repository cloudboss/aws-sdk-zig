/// Contains information about an Identity and Access Management user.
pub const IAMUserIdentity = struct {
    /// The ARN of the IAM user. For more information, see [IAM
    /// ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html) in the
    /// *IAM User Guide*.
    ///
    /// If you delete the IAM user, access policies that contain this identity
    /// include an
    /// empty `arn`. You can delete the access policy for the IAM user that no
    /// longer
    /// exists.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
