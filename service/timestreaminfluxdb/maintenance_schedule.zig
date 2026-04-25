/// Specifies the maintenance schedule for a DB instance or cluster, defining
/// when maintenance operations such as patching can be performed.
pub const MaintenanceSchedule = struct {
    /// The preferred maintenance window in the format ddd:HH:MM-ddd:HH:MM (UTC).
    /// Day must be one of: Mon, Tue, Wed, Thu, Fri, Sat, Sun. For example,
    /// Sun:02:00-Sun:06:00. Provide an empty string to let the system choose a
    /// window.
    preferred_maintenance_window: []const u8,

    /// The IANA timezone identifier for the maintenance window. Format: Region/City
    /// or UTC. For example, America/New_York or UTC.
    timezone: []const u8,

    pub const json_field_names = .{
        .preferred_maintenance_window = "preferredMaintenanceWindow",
        .timezone = "timezone",
    };
};
