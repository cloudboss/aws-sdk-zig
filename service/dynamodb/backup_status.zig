pub const BackupStatus = enum {
    creating,
    deleted,
    available,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleted = "DELETED",
        .available = "AVAILABLE",
    };
};
