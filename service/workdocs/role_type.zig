pub const RoleType = enum {
    viewer,
    contributor,
    owner,
    coowner,

    pub const json_field_names = .{
        .viewer = "VIEWER",
        .contributor = "CONTRIBUTOR",
        .owner = "OWNER",
        .coowner = "COOWNER",
    };
};
