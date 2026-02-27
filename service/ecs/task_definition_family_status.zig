pub const TaskDefinitionFamilyStatus = enum {
    active,
    inactive,
    all,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .all = "ALL",
    };
};
