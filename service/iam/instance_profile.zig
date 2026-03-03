const Role = @import("role.zig").Role;
const Tag = @import("tag.zig").Tag;

/// Contains information about an instance profile.
///
/// This data type is used as a response element in the following operations:
///
/// *
///   [CreateInstanceProfile](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateInstanceProfile.html)
///
/// *
///   [GetInstanceProfile](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetInstanceProfile.html)
///
/// *
///   [ListInstanceProfiles](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListInstanceProfiles.html)
///
/// *
///   [ListInstanceProfilesForRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListInstanceProfilesForRole.html)
pub const InstanceProfile = struct {
    /// The Amazon Resource Name (ARN) specifying the instance profile. For more
    /// information
    /// about ARNs and how to use them in policies, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the
    /// *IAM User Guide*.
    arn: []const u8,

    /// The date when the instance profile was created.
    create_date: i64,

    /// The stable and unique string identifying the instance profile. For more
    /// information
    /// about IDs, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the *IAM User Guide*.
    instance_profile_id: []const u8,

    /// The name identifying the instance profile.
    instance_profile_name: []const u8,

    /// The path to the instance profile. For more information about paths, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the *IAM User Guide*.
    path: []const u8,

    /// The role associated with the instance profile.
    roles: []const Role,

    /// A list of tags that are attached to the instance profile. For more
    /// information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    tags: ?[]const Tag = null,
};
