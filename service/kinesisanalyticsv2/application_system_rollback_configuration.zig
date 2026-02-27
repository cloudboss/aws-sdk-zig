/// Describes the system rollback configuration for a Managed Service for Apache
/// Flink application.
pub const ApplicationSystemRollbackConfiguration = struct {
    /// Describes whether system rollbacks are enabled for a Managed Service for
    /// Apache Flink application.
    rollback_enabled: bool,

    pub const json_field_names = .{
        .rollback_enabled = "RollbackEnabled",
    };
};
