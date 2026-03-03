const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .flow_logs => "FLOW_LOGS",
            .cloud_trail => "CLOUD_TRAIL",
            .dns_logs => "DNS_LOGS",
            .s3_logs => "S3_LOGS",
            .kubernetes_audit_logs => "KUBERNETES_AUDIT_LOGS",
            .ec2_malware_scan => "EC2_MALWARE_SCAN",
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
