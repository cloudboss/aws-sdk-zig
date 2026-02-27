pub const PermissionStatus = enum {
    attachable,
    unattachable,
    deleting,
    deleted,

    pub const json_field_names = .{
        .attachable = "ATTACHABLE",
        .unattachable = "UNATTACHABLE",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};
