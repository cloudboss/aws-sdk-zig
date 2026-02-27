pub const DetectorFeature = enum {
    s3_data_events,
    eks_audit_logs,
    ebs_malware_protection,
    rds_login_events,
    eks_runtime_monitoring,
    lambda_network_logs,
    runtime_monitoring,

    pub const json_field_names = .{
        .s3_data_events = "S3_DATA_EVENTS",
        .eks_audit_logs = "EKS_AUDIT_LOGS",
        .ebs_malware_protection = "EBS_MALWARE_PROTECTION",
        .rds_login_events = "RDS_LOGIN_EVENTS",
        .eks_runtime_monitoring = "EKS_RUNTIME_MONITORING",
        .lambda_network_logs = "LAMBDA_NETWORK_LOGS",
        .runtime_monitoring = "RUNTIME_MONITORING",
    };
};
