pub const CrossAccountFilterOption = enum {
    same_account,
    cross_account,

    pub const json_field_names = .{
        .same_account = "SAME_ACCOUNT",
        .cross_account = "CROSS_ACCOUNT",
    };
};
