/// Specifies the rollback state while disabling Auto-Tune for the domain. Valid
/// values are NO_ROLLBACK, DEFAULT_ROLLBACK.
pub const RollbackOnDisable = enum {
    no_rollback,
    default_rollback,

    pub const json_field_names = .{
        .no_rollback = "NO_ROLLBACK",
        .default_rollback = "DEFAULT_ROLLBACK",
    };
};
