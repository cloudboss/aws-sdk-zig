pub const WorkloadStatus = enum {
    active,
    inactive,
    disabled,
    deleted,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .disabled = "DISABLED",
        .deleted = "DELETED",
    };
};
