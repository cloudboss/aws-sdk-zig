pub const ServiceDeploymentRollbackMonitorsStatus = enum {
    triggered,
    monitoring,
    monitoring_complete,
    disabled,

    pub const json_field_names = .{
        .triggered = "TRIGGERED",
        .monitoring = "MONITORING",
        .monitoring_complete = "MONITORING_COMPLETE",
        .disabled = "DISABLED",
    };
};
