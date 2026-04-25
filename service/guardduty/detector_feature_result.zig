const std = @import("std");

pub const DetectorFeatureResult = enum {
    flow_logs,
    cloud_trail,
    dns_logs,
    s3_data_events,
    eks_audit_logs,
    ebs_malware_protection,
    rds_login_events,
    lambda_network_logs,
    eks_runtime_monitoring,
    runtime_monitoring,

    pub const json_field_names = .{
        .flow_logs = "FLOW_LOGS",
        .cloud_trail = "CLOUD_TRAIL",
        .dns_logs = "DNS_LOGS",
        .s3_data_events = "S3_DATA_EVENTS",
        .eks_audit_logs = "EKS_AUDIT_LOGS",
        .ebs_malware_protection = "EBS_MALWARE_PROTECTION",
        .rds_login_events = "RDS_LOGIN_EVENTS",
        .lambda_network_logs = "LAMBDA_NETWORK_LOGS",
        .eks_runtime_monitoring = "EKS_RUNTIME_MONITORING",
        .runtime_monitoring = "RUNTIME_MONITORING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .flow_logs => "FLOW_LOGS",
            .cloud_trail => "CLOUD_TRAIL",
            .dns_logs => "DNS_LOGS",
            .s3_data_events => "S3_DATA_EVENTS",
            .eks_audit_logs => "EKS_AUDIT_LOGS",
            .ebs_malware_protection => "EBS_MALWARE_PROTECTION",
            .rds_login_events => "RDS_LOGIN_EVENTS",
            .lambda_network_logs => "LAMBDA_NETWORK_LOGS",
            .eks_runtime_monitoring => "EKS_RUNTIME_MONITORING",
            .runtime_monitoring => "RUNTIME_MONITORING",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
