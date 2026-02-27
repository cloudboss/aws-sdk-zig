pub const ActivationOverrideBehavior = enum {
    distributed_grants_only,
    all_grants_permitted_by_issuer,

    pub const json_field_names = .{
        .distributed_grants_only = "DISTRIBUTED_GRANTS_ONLY",
        .all_grants_permitted_by_issuer = "ALL_GRANTS_PERMITTED_BY_ISSUER",
    };
};
