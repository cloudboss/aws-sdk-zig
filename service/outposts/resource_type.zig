pub const ResourceType = enum {
    outpost,
    order,

    pub const json_field_names = .{
        .outpost = "OUTPOST",
        .order = "ORDER",
    };
};
