pub const TargetHealthReason = enum {
    @"unreachable",
    connection_failed,
    auth_failure,
    pending_proxy_capacity,
    invalid_replication_state,
    promoted,
};
