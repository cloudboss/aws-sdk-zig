const AttachedPermissionsBoundary = @import("attached_permissions_boundary.zig").AttachedPermissionsBoundary;
const Tag = @import("tag.zig").Tag;

/// Contains information about an IAM user entity.
///
/// This data type is used as a response element in the following operations:
///
/// *
///   [CreateUser](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateUser.html)
///
/// *
///   [GetUser](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetUser.html)
///
/// *
///   [ListUsers](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListUsers.html)
pub const User = struct {
    /// The Amazon Resource Name (ARN) that identifies the user. For more
    /// information about ARNs
    /// and how to use ARNs in policies, see [IAM
    /// Identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the
    /// *IAM User Guide*.
    arn: []const u8,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the user was created.
    create_date: i64,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the user's password was last
    /// used to sign in to an Amazon Web Services website.
    /// For a list of Amazon Web Services websites that capture a user's last
    /// sign-in time, see the [Credential
    /// reports](https://docs.aws.amazon.com/IAM/latest/UserGuide/credential-reports.html) topic in the *IAM User Guide*. If a password is
    /// used more than once in a five-minute span, only the first use is returned in
    /// this field. If
    /// the field is null (no value), then it indicates that they never signed in
    /// with a password.
    /// This can be because:
    ///
    /// * The user never had a password.
    ///
    /// * A password exists but has not been used since IAM started tracking this
    /// information on October 20, 2014.
    ///
    /// A null value does not mean that the user *never* had a password.
    /// Also, if the user does not currently have a password but had one in the
    /// past, then this
    /// field contains the date and time the most recent password was used.
    ///
    /// This value is returned only in the
    /// [GetUser](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetUser.html) and [ListUsers](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListUsers.html)
    /// operations.
    password_last_used: ?i64,

    /// The path to the user. For more information about paths, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the
    /// *IAM User Guide*.
    ///
    /// The ARN of the policy used to set the permissions boundary for the user.
    path: []const u8,

    /// For more information about permissions boundaries, see [Permissions
    /// boundaries for IAM
    /// identities
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html) in the *IAM User Guide*.
    permissions_boundary: ?AttachedPermissionsBoundary,

    /// A list of tags that are associated with the user. For more information about
    /// tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    tags: ?[]const Tag,

    /// The stable and unique string identifying the user. For more information
    /// about IDs, see
    /// [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the *IAM User Guide*.
    user_id: []const u8,

    /// The friendly name identifying the user.
    user_name: []const u8,
};
