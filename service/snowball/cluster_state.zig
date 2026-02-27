pub const ClusterState = enum {
    awaiting_quorum,
    pending,
    in_use,
    complete,
    cancelled,

    pub const json_field_names = .{
        .awaiting_quorum = "AWAITING_QUORUM",
        .pending = "PENDING",
        .in_use = "IN_USE",
        .complete = "COMPLETE",
        .cancelled = "CANCELLED",
    };
};
