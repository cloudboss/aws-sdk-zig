pub const HybridUpdateType = enum {
    self_managed_instances,
    hybrid_administrator_account,

    pub const json_field_names = .{
        .self_managed_instances = "SELF_MANAGED_INSTANCES",
        .hybrid_administrator_account = "HYBRID_ADMINISTRATOR_ACCOUNT",
    };
};
