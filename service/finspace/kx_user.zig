/// A structure that stores metadata for a kdb user.
pub const KxUser = struct {
    /// The timestamp at which the kdb user was created.
    create_timestamp: ?i64,

    /// The IAM role ARN that is associated with the user.
    iam_role: ?[]const u8,

    /// The timestamp at which the kdb user was updated.
    update_timestamp: ?i64,

    /// The Amazon Resource Name (ARN) that identifies the user. For more
    /// information about ARNs and
    /// how to use ARNs in policies, see [IAM
    /// Identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html) in the
    /// *IAM User Guide*.
    user_arn: ?[]const u8,

    /// A unique identifier for the user.
    user_name: ?[]const u8,

    pub const json_field_names = .{
        .create_timestamp = "createTimestamp",
        .iam_role = "iamRole",
        .update_timestamp = "updateTimestamp",
        .user_arn = "userArn",
        .user_name = "userName",
    };
};
