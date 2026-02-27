pub const Op = enum {
    add,
    remove,
    replace,
    move,
    copy,
    @"test",

    pub const json_field_names = .{
        .add = "add",
        .remove = "remove",
        .replace = "replace",
        .move = "move",
        .copy = "copy",
        .@"test" = "test",
    };
};
