pub const WorkspaceImageRequiredTenancy = enum {
    default,
    dedicated,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .dedicated = "DEDICATED",
    };
};
