pub const InputTags = enum {
    honor,
    ignore,

    pub const json_field_names = .{
        .honor = "HONOR",
        .ignore = "IGNORE",
    };
};
