const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .finding => "FINDING",
            .cloud_trail => "CLOUD_TRAIL",
            .s3_data_events => "S3_DATA_EVENTS",
            .eks_audit_logs => "EKS_AUDIT_LOGS",
            .flow_logs => "FLOW_LOGS",
            .dns_logs => "DNS_LOGS",
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
