pub const EksAnywhereSubscriptionStatus = enum {
    creating,
    active,
    updating,
    expiring,
    expired,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .updating = "UPDATING",
        .expiring = "EXPIRING",
        .expired = "EXPIRED",
        .deleting = "DELETING",
    };
};
