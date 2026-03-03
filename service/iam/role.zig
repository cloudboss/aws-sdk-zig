const AttachedPermissionsBoundary = @import("attached_permissions_boundary.zig").AttachedPermissionsBoundary;
const RoleLastUsed = @import("role_last_used.zig").RoleLastUsed;
const Tag = @import("tag.zig").Tag;

/// Contains information about an IAM role. This structure is returned as a
/// response
/// element in several API operations that interact with roles.
pub const Role = struct {
    /// The Amazon Resource Name (ARN) specifying the role. For more information
    /// about ARNs and
    /// how to use them in policies, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the
    /// *IAM User Guide* guide.
    arn: []const u8,

    /// The policy that grants an entity permission to assume the role.
    assume_role_policy_document: ?[]const u8 = null,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the role was created.
    create_date: i64,

    /// A description of the role that you provide.
    description: ?[]const u8 = null,

    /// The maximum session duration (in seconds) for the specified role. Anyone who
    /// uses the
    /// CLI, or API to assume the role can specify the duration using the optional
    /// `DurationSeconds` API parameter or `duration-seconds` CLI
    /// parameter.
    max_session_duration: ?i32 = null,

    /// The path to the role. For more information about paths, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the
    /// *IAM User Guide*.
    path: []const u8,

    /// The ARN of the policy used to set the permissions boundary for the role.
    ///
    /// For more information about permissions boundaries, see [Permissions
    /// boundaries for IAM
    /// identities
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html) in the *IAM User Guide*.
    permissions_boundary: ?AttachedPermissionsBoundary = null,

    /// The stable and unique string identifying the role. For more information
    /// about IDs, see
    /// [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the *IAM User Guide*.
    role_id: []const u8,

    /// Contains information about the last time that an IAM role was used. This
    /// includes the
    /// date and time and the Region in which the role was last used. Activity is
    /// only reported for
    /// the trailing 400 days. This period can be shorter if your Region began
    /// supporting these
    /// features within the last year. The role might have been used more than 400
    /// days ago. For
    /// more information, see [Regions where data is
    /// tracked](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_access-advisor.html#access-advisor_tracking-period) in the *IAM user
    /// Guide*.
    role_last_used: ?RoleLastUsed = null,

    /// The friendly name that identifies the role.
    role_name: []const u8,

    /// A list of tags that are attached to the role. For more information about
    /// tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    tags: ?[]const Tag = null,
};
