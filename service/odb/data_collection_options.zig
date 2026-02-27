/// Information about the data collection options enabled for a VM cluster.
pub const DataCollectionOptions = struct {
    /// Indicates whether diagnostic collection is enabled for the VM cluster.
    is_diagnostics_events_enabled: ?bool,

    /// Indicates whether health monitoring is enabled for the VM cluster.
    is_health_monitoring_enabled: ?bool,

    /// Indicates whether incident logs are enabled for the cloud VM cluster.
    is_incident_logs_enabled: ?bool,

    pub const json_field_names = .{
        .is_diagnostics_events_enabled = "isDiagnosticsEventsEnabled",
        .is_health_monitoring_enabled = "isHealthMonitoringEnabled",
        .is_incident_logs_enabled = "isIncidentLogsEnabled",
    };
};
