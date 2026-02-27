pub const ZeroETLIntegrationStatus = enum {
    creating,
    active,
    modifying,
    failed,
    deleting,
    syncing,
    needs_attention,
};
