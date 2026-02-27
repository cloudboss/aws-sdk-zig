pub const GameServerGroupDeleteOption = enum {
    safe_delete,
    force_delete,
    retain,

    pub const json_field_names = .{
        .safe_delete = "SAFE_DELETE",
        .force_delete = "FORCE_DELETE",
        .retain = "RETAIN",
    };
};
