pub const InstalledComponentTopologyFilter = enum {
    all,
    root,

    pub const json_field_names = .{
        .all = "ALL",
        .root = "ROOT",
    };
};
