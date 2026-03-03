const IamIdentity = @import("iam_identity.zig").IamIdentity;

/// Information about the user who created or modified a SageMaker resource.
pub const UserContext = struct {
    /// The domain associated with the user.
    domain_id: ?[]const u8 = null,

    /// The IAM Identity details associated with the user. These details are
    /// associated with model package groups, model packages, and project entities
    /// only.
    iam_identity: ?IamIdentity = null,

    /// The Amazon Resource Name (ARN) of the user's profile.
    user_profile_arn: ?[]const u8 = null,

    /// The name of the user's profile.
    user_profile_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .iam_identity = "IamIdentity",
        .user_profile_arn = "UserProfileArn",
        .user_profile_name = "UserProfileName",
    };
};
