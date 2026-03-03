const RoomMembershipRole = @import("room_membership_role.zig").RoomMembershipRole;

/// Membership details, such as member ID and member role.
pub const MembershipItem = struct {
    /// The member ID.
    member_id: ?[]const u8 = null,

    /// The member role.
    role: ?RoomMembershipRole = null,

    pub const json_field_names = .{
        .member_id = "MemberId",
        .role = "Role",
    };
};
