const Member = @import("member.zig").Member;
const RoomMembershipRole = @import("room_membership_role.zig").RoomMembershipRole;

/// The room membership details.
pub const RoomMembership = struct {
    /// The identifier of the user that invited the room member.
    invited_by: ?[]const u8 = null,

    /// The member details, such as email address, name, member ID, and member type.
    member: ?Member = null,

    /// The membership role.
    role: ?RoomMembershipRole = null,

    /// The room ID.
    room_id: ?[]const u8 = null,

    /// The room membership update timestamp, in ISO 8601 format.
    updated_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .invited_by = "InvitedBy",
        .member = "Member",
        .role = "Role",
        .room_id = "RoomId",
        .updated_timestamp = "UpdatedTimestamp",
    };
};
