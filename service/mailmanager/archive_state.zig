pub const ArchiveState = enum {
    active,
    pending_deletion,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .pending_deletion = "PENDING_DELETION",
    };
};
