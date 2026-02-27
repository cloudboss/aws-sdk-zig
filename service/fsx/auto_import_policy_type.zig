pub const AutoImportPolicyType = enum {
    none,
    new,
    new_changed,
    new_changed_deleted,

    pub const json_field_names = .{
        .none = "NONE",
        .new = "NEW",
        .new_changed = "NEW_CHANGED",
        .new_changed_deleted = "NEW_CHANGED_DELETED",
    };
};
