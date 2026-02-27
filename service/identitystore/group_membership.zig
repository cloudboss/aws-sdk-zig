const MemberId = @import("member_id.zig").MemberId;

/// Contains the identifiers for a group, a group member, and a
/// `GroupMembership` object in the identity store.
pub const GroupMembership = struct {
    /// The date and time the group membership was created.
    created_at: ?i64,

    /// The identifier of the user or system that created the group membership.
    created_by: ?[]const u8,

    /// The identifier for a group in the identity store.
    group_id: ?[]const u8,

    /// The globally unique identifier for the identity store.
    identity_store_id: []const u8,

    /// An object that contains the identifier of a group member. Setting the
    /// `UserID` field to the specific identifier for a user indicates that the user
    /// is a member of the group.
    member_id: ?MemberId,

    /// The identifier for a `GroupMembership` object in an identity store.
    membership_id: ?[]const u8,

    /// The date and time the group membership was last updated.
    updated_at: ?i64,

    /// The identifier of the user or system that last updated the group membership.
    updated_by: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .created_by = "CreatedBy",
        .group_id = "GroupId",
        .identity_store_id = "IdentityStoreId",
        .member_id = "MemberId",
        .membership_id = "MembershipId",
        .updated_at = "UpdatedAt",
        .updated_by = "UpdatedBy",
    };
};
