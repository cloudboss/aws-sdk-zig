/// A user pool group. Contains details about the group and the way that it
/// contributes to
/// IAM role decisions with identity pools. Identity pools can make decisions
/// about the
/// IAM role to assign based on groups: users get credentials for the role
/// associated with
/// their highest-priority group.
pub const GroupType = struct {
    /// The date and time when the item was created. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    creation_date: ?i64 = null,

    /// A friendly description of the group.
    description: ?[]const u8 = null,

    /// The name of the group.
    group_name: ?[]const u8 = null,

    /// The date and time when the item was modified. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    last_modified_date: ?i64 = null,

    /// A non-negative integer value that specifies the precedence of this group
    /// relative to
    /// the other groups that a user can belong to in the user pool. Zero is the
    /// highest
    /// precedence value. Groups with lower `Precedence` values take precedence over
    /// groups with higher ornull `Precedence` values. If a user belongs to two or
    /// more groups, it is the group with the lowest precedence value whose role ARN
    /// is given in
    /// the user's tokens for the `cognito:roles` and
    /// `cognito:preferred_role` claims.
    ///
    /// Two groups can have the same `Precedence` value. If this happens, neither
    /// group takes precedence over the other. If two groups with the same
    /// `Precedence` have the same role ARN, that role is used in the
    /// `cognito:preferred_role` claim in tokens for users in each group. If the
    /// two groups have different role ARNs, the `cognito:preferred_role` claim
    /// isn't
    /// set in users' tokens.
    ///
    /// The default `Precedence` value is `null`.
    precedence: ?i32 = null,

    /// The ARN of the IAM role associated with the group. If a group has the
    /// highest
    /// priority of a user's groups, users who authenticate with an identity pool
    /// get
    /// credentials for the `RoleArn` that's associated with the group.
    role_arn: ?[]const u8 = null,

    /// The ID of the user pool that contains the group.
    user_pool_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .description = "Description",
        .group_name = "GroupName",
        .last_modified_date = "LastModifiedDate",
        .precedence = "Precedence",
        .role_arn = "RoleArn",
        .user_pool_id = "UserPoolId",
    };
};
