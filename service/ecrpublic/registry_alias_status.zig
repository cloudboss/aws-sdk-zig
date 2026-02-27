pub const RegistryAliasStatus = enum {
    active,
    pending,
    rejected,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .pending = "PENDING",
        .rejected = "REJECTED",
    };
};
