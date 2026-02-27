pub const ResourceType = enum {
    room,
    equipment,

    pub const json_field_names = .{
        .room = "ROOM",
        .equipment = "EQUIPMENT",
    };
};
