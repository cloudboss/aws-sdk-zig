pub const PerObjectSyncStatus = enum {
    pending,
    in_sync,
    capacity_constrained,
    not_subscribed,
    deprecated,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_sync = "IN_SYNC",
        .capacity_constrained = "CAPACITY_CONSTRAINED",
        .not_subscribed = "NOT_SUBSCRIBED",
        .deprecated = "DEPRECATED",
    };
};
