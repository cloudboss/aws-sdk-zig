pub const LicenseDeletionStatus = enum {
    pending_delete,
    deleted,

    pub const json_field_names = .{
        .pending_delete = "PENDING_DELETE",
        .deleted = "DELETED",
    };
};
