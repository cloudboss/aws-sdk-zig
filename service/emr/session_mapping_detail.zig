const IdentityType = @import("identity_type.zig").IdentityType;

/// Details for an Amazon EMR Studio session mapping including creation time,
/// user
/// or group ID, Studio ID, and so on.
pub const SessionMappingDetail = struct {
    /// The time the session mapping was created.
    creation_time: ?i64 = null,

    /// The globally unique identifier (GUID) of the user or group.
    identity_id: ?[]const u8 = null,

    /// The name of the user or group. For more information, see
    /// [UserName](https://docs.aws.amazon.com/singlesignon/latest/IdentityStoreAPIReference/API_User.html#singlesignon-Type-User-UserName) and [DisplayName](https://docs.aws.amazon.com/singlesignon/latest/IdentityStoreAPIReference/API_Group.html#singlesignon-Type-Group-DisplayName) in the *IAM Identity Center Identity Store API
    /// Reference*.
    identity_name: ?[]const u8 = null,

    /// Specifies whether the identity mapped to the Amazon EMR Studio is a user or
    /// a
    /// group.
    identity_type: ?IdentityType = null,

    /// The time the session mapping was last modified.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the session policy associated with the
    /// user or
    /// group.
    session_policy_arn: ?[]const u8 = null,

    /// The ID of the Amazon EMR Studio.
    studio_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .identity_id = "IdentityId",
        .identity_name = "IdentityName",
        .identity_type = "IdentityType",
        .last_modified_time = "LastModifiedTime",
        .session_policy_arn = "SessionPolicyArn",
        .studio_id = "StudioId",
    };
};
