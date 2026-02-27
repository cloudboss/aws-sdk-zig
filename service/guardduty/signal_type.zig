pub const SignalType = enum {
    finding,
    cloud_trail,
    s3_data_events,
    eks_audit_logs,
    flow_logs,
    dns_logs,
    runtime_monitoring,

    pub const json_field_names = .{
        .finding = "FINDING",
        .cloud_trail = "CLOUD_TRAIL",
        .s3_data_events = "S3_DATA_EVENTS",
        .eks_audit_logs = "EKS_AUDIT_LOGS",
        .flow_logs = "FLOW_LOGS",
        .dns_logs = "DNS_LOGS",
        .runtime_monitoring = "RUNTIME_MONITORING",
    };
};
