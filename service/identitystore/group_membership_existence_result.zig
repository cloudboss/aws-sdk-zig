const MemberId = @import("member_id.zig").MemberId;

/// Indicates whether a resource is a member of a group in the identity store.
pub const GroupMembershipExistenceResult = struct {
    /// The identifier for a group in the identity store.
    group_id: ?[]const u8,

    /// An object that contains the identifier of a group member. Setting the
    /// `UserID` field to the specific identifier for a user indicates that the user
    /// is a member of the group.
    member_id: ?MemberId,

    /// Indicates whether a membership relation exists or not.
    membership_exists: bool = false,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .member_id = "MemberId",
        .membership_exists = "MembershipExists",
    };
};
