pub const IntegrationStatus = enum {
    creating,
    active,
    modifying,
    failed,
    deleting,
    syncing,
    needs_attention,
};
