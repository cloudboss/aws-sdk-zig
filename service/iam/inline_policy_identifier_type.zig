const AttachmentType = @import("attachment_type.zig").AttachmentType;

/// Identifies one or more inline policies that are embedded in IAM users,
/// groups, or
/// roles, by the name of the policy together with the type and name of the
/// entity that it is
/// attached to. Wildcard characters in the entity name can match multiple
/// entities, so a
/// single identifier can select more than one attached inline policy.
pub const InlinePolicyIdentifierType = struct {
    /// The name of the IAM user, group, or role that the inline policy is attached
    /// to.
    /// Wildcard characters are supported to match multiple entities: use at most
    /// one
    /// `*` (matches any sequence of characters, including none), and any number of
    /// `?` (each matches exactly one character).
    attachment_name: []const u8,

    /// The type of IAM entity that the inline policy is attached to.
    attachment_type: AttachmentType,

    /// The name of the inline policy.
    policy_name: []const u8,
};
