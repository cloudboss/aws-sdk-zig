pub const RoomMembershipRole = enum {
    administrator,
    member,

    pub const json_field_names = .{
        .administrator = "Administrator",
        .member = "Member",
    };
};
