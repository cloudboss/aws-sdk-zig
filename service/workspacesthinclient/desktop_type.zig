pub const DesktopType = enum {
    workspaces,
    appstream,
    workspaces_web,

    pub const json_field_names = .{
        .workspaces = "WORKSPACES",
        .appstream = "APPSTREAM",
        .workspaces_web = "WORKSPACES_WEB",
    };
};
