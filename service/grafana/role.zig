pub const Role = enum {
    /// Role Admin.
    admin,
    /// Role Editor.
    editor,
    /// Role Viewer.
    viewer,

    pub const json_field_names = .{
        .admin = "ADMIN",
        .editor = "EDITOR",
        .viewer = "VIEWER",
    };
};
