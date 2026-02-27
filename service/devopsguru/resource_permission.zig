pub const ResourcePermission = enum {
    full_permission,
    missing_permission,

    pub const json_field_names = .{
        .full_permission = "FULL_PERMISSION",
        .missing_permission = "MISSING_PERMISSION",
    };
};
