pub const DynamicGroupStatus = enum {
    active,
    building,
    rebuilding,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .building = "BUILDING",
        .rebuilding = "REBUILDING",
    };
};
