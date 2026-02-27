pub const RecoveryApproach = enum {
    active_active,
    active_passive,

    pub const json_field_names = .{
        .active_active = "ACTIVE_ACTIVE",
        .active_passive = "ACTIVE_PASSIVE",
    };
};
