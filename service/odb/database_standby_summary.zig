const AutonomousDatabaseResourceStatus = @import("autonomous_database_resource_status.zig").AutonomousDatabaseResourceStatus;

/// A summary of a standby Autonomous Database in an Oracle Data Guard
/// configuration.
pub const DatabaseStandbySummary = struct {
    /// The availability domain of the standby Autonomous Database.
    availability_domain: ?[]const u8 = null,

    /// The time lag, in seconds, between the standby database and the primary
    /// database.
    lag_time_in_seconds: ?i32 = null,

    /// The component on the standby Autonomous Database that the current
    /// maintenance is being applied to.
    maintenance_target_component: ?[]const u8 = null,

    /// The current status of the standby Autonomous Database.
    status: ?AutonomousDatabaseResourceStatus = null,

    /// Additional information about the current status of the standby Autonomous
    /// Database, if applicable.
    status_reason: ?[]const u8 = null,

    /// The date and time when the Oracle Data Guard role of the standby database
    /// last changed.
    time_data_guard_role_changed: ?i64 = null,

    /// The date and time when the disaster recovery role of the standby database
    /// last changed.
    time_disaster_recovery_role_changed: ?i64 = null,

    /// The date and time when the next maintenance of the standby database begins.
    time_maintenance_begin: ?i64 = null,

    /// The date and time when the next maintenance of the standby database ends.
    time_maintenance_end: ?i64 = null,

    pub const json_field_names = .{
        .availability_domain = "availabilityDomain",
        .lag_time_in_seconds = "lagTimeInSeconds",
        .maintenance_target_component = "maintenanceTargetComponent",
        .status = "status",
        .status_reason = "statusReason",
        .time_data_guard_role_changed = "timeDataGuardRoleChanged",
        .time_disaster_recovery_role_changed = "timeDisasterRecoveryRoleChanged",
        .time_maintenance_begin = "timeMaintenanceBegin",
        .time_maintenance_end = "timeMaintenanceEnd",
    };
};
