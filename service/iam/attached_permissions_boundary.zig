const PermissionsBoundaryAttachmentType = @import("permissions_boundary_attachment_type.zig").PermissionsBoundaryAttachmentType;

/// Contains information about an attached permissions boundary.
///
/// An attached permissions boundary is a managed policy that has been attached
/// to a user or
/// role to set the permissions boundary.
///
/// For more information about permissions boundaries, see [Permissions
/// boundaries for IAM
/// identities
/// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html) in the *IAM User Guide*.
pub const AttachedPermissionsBoundary = struct {
    /// The ARN of the policy used to set the permissions boundary for the user or
    /// role.
    permissions_boundary_arn: ?[]const u8,

    /// The permissions boundary usage type that indicates what type of IAM resource
    /// is used
    /// as the permissions boundary for an entity. This data type can only have a
    /// value of
    /// `Policy`.
    permissions_boundary_type: ?PermissionsBoundaryAttachmentType,
};
