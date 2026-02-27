pub const IntegrationStatus = enum {
    creating,
    active,
    modifying,
    failed,
    deleting,
    syncing,
    needs_attention,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .modifying = "MODIFYING",
        .failed = "FAILED",
        .deleting = "DELETING",
        .syncing = "SYNCING",
        .needs_attention = "NEEDS_ATTENTION",
    };
};
