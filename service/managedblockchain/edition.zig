pub const Edition = enum {
    starter,
    standard,

    pub const json_field_names = .{
        .starter = "STARTER",
        .standard = "STANDARD",
    };
};
