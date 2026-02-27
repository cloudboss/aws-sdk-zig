pub const ArgoCdRole = enum {
    admin,
    editor,
    viewer,

    pub const json_field_names = .{
        .admin = "ADMIN",
        .editor = "EDITOR",
        .viewer = "VIEWER",
    };
};
