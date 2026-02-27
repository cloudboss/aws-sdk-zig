pub const DataSource = enum {
    flow_logs,
    cloud_trail,
    dns_logs,
    s3_logs,
    kubernetes_audit_logs,
    ec2_malware_scan,

    pub const json_field_names = .{
        .flow_logs = "FLOW_LOGS",
        .cloud_trail = "CLOUD_TRAIL",
        .dns_logs = "DNS_LOGS",
        .s3_logs = "S3_LOGS",
        .kubernetes_audit_logs = "KUBERNETES_AUDIT_LOGS",
        .ec2_malware_scan = "EC2_MALWARE_SCAN",
    };
};
