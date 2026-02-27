const MemberType = @import("member_type.zig").MemberType;
const PermissionType = @import("permission_type.zig").PermissionType;

/// Permission granted to a user, group, or resource to access a certain aspect
/// of
/// another user, group, or resource mailbox.
pub const Permission = struct {
    /// The identifier of the user, group, or resource to which the permissions are
    /// granted.
    grantee_id: []const u8,

    /// The type of user, group, or resource referred to in GranteeId.
    grantee_type: MemberType,

    /// The permissions granted to the grantee. SEND_AS allows the grantee to send
    /// email as
    /// the owner of the mailbox (the grantee is not mentioned on these emails).
    /// SEND_ON_BEHALF
    /// allows the grantee to send email on behalf of the owner of the mailbox (the
    /// grantee is not
    /// mentioned as the physical sender of these emails). FULL_ACCESS allows the
    /// grantee full
    /// access to the mailbox, irrespective of other folder-level permissions set on
    /// the
    /// mailbox.
    permission_values: []const PermissionType,

    pub const json_field_names = .{
        .grantee_id = "GranteeId",
        .grantee_type = "GranteeType",
        .permission_values = "PermissionValues",
    };
};
