pub const ShareStatus = enum {
    /// The share has been created but is not yet active
    pending,
    /// The share is activated
    activating,
    /// The share is active and can be used
    active,
    /// The share is being deleted
    deleting,
    /// The share has been deleted
    deleted,
    /// The share has failed to activate or delete
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .activating = "ACTIVATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .failed = "FAILED",
    };
};
