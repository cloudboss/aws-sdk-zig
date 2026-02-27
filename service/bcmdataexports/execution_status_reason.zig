pub const ExecutionStatusReason = enum {
    insufficient_permission,
    bill_owner_changed,
    internal_failure,

    pub const json_field_names = .{
        .insufficient_permission = "INSUFFICIENT_PERMISSION",
        .bill_owner_changed = "BILL_OWNER_CHANGED",
        .internal_failure = "INTERNAL_FAILURE",
    };
};
