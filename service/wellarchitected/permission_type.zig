/// Permission granted on a share request.
pub const PermissionType = enum {
    readonly,
    contributor,

    pub const json_field_names = .{
        .readonly = "READONLY",
        .contributor = "CONTRIBUTOR",
    };
};
