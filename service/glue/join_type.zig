pub const JoinType = enum {
    equijoin,
    left,
    right,
    outer,
    left_semi,
    left_anti,

    pub const json_field_names = .{
        .equijoin = "EQUIJOIN",
        .left = "LEFT",
        .right = "RIGHT",
        .outer = "OUTER",
        .left_semi = "LEFT_SEMI",
        .left_anti = "LEFT_ANTI",
    };
};
