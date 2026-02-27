pub const UpdateStrategy = enum {
    coordinated,
    uncoordinated,

    pub const json_field_names = .{
        .coordinated = "COORDINATED",
        .uncoordinated = "UNCOORDINATED",
    };
};
