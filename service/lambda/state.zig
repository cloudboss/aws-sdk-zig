pub const State = enum {
    pending,
    active,
    inactive,
    failed,
    deactivating,
    deactivated,
    active_non_invocable,
    deleting,

    pub const json_field_names = .{
        .pending = "Pending",
        .active = "Active",
        .inactive = "Inactive",
        .failed = "Failed",
        .deactivating = "Deactivating",
        .deactivated = "Deactivated",
        .active_non_invocable = "ActiveNonInvocable",
        .deleting = "Deleting",
    };
};
