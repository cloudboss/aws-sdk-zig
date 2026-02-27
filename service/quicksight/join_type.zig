pub const JoinType = enum {
    inner,
    outer,
    left,
    right,

    pub const json_field_names = .{
        .inner = "INNER",
        .outer = "OUTER",
        .left = "LEFT",
        .right = "RIGHT",
    };
};
