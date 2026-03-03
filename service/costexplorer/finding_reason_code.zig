const std = @import("std");

pub const FindingReasonCode = enum {
    cpu_over_provisioned,
    cpu_under_provisioned,
    memory_over_provisioned,
    memory_under_provisioned,
    ebs_throughput_over_provisioned,
    ebs_throughput_under_provisioned,
    ebs_iops_over_provisioned,
    ebs_iops_under_provisioned,
    network_bandwidth_over_provisioned,
    network_bandwidth_under_provisioned,
    network_pps_over_provisioned,
    network_pps_under_provisioned,
    disk_iops_over_provisioned,
    disk_iops_under_provisioned,
    disk_throughput_over_provisioned,
    disk_throughput_under_provisioned,

    pub const json_field_names = .{
        .cpu_over_provisioned = "CPU_OVER_PROVISIONED",
        .cpu_under_provisioned = "CPU_UNDER_PROVISIONED",
        .memory_over_provisioned = "MEMORY_OVER_PROVISIONED",
        .memory_under_provisioned = "MEMORY_UNDER_PROVISIONED",
        .ebs_throughput_over_provisioned = "EBS_THROUGHPUT_OVER_PROVISIONED",
        .ebs_throughput_under_provisioned = "EBS_THROUGHPUT_UNDER_PROVISIONED",
        .ebs_iops_over_provisioned = "EBS_IOPS_OVER_PROVISIONED",
        .ebs_iops_under_provisioned = "EBS_IOPS_UNDER_PROVISIONED",
        .network_bandwidth_over_provisioned = "NETWORK_BANDWIDTH_OVER_PROVISIONED",
        .network_bandwidth_under_provisioned = "NETWORK_BANDWIDTH_UNDER_PROVISIONED",
        .network_pps_over_provisioned = "NETWORK_PPS_OVER_PROVISIONED",
        .network_pps_under_provisioned = "NETWORK_PPS_UNDER_PROVISIONED",
        .disk_iops_over_provisioned = "DISK_IOPS_OVER_PROVISIONED",
        .disk_iops_under_provisioned = "DISK_IOPS_UNDER_PROVISIONED",
        .disk_throughput_over_provisioned = "DISK_THROUGHPUT_OVER_PROVISIONED",
        .disk_throughput_under_provisioned = "DISK_THROUGHPUT_UNDER_PROVISIONED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cpu_over_provisioned => "CPU_OVER_PROVISIONED",
            .cpu_under_provisioned => "CPU_UNDER_PROVISIONED",
            .memory_over_provisioned => "MEMORY_OVER_PROVISIONED",
            .memory_under_provisioned => "MEMORY_UNDER_PROVISIONED",
            .ebs_throughput_over_provisioned => "EBS_THROUGHPUT_OVER_PROVISIONED",
            .ebs_throughput_under_provisioned => "EBS_THROUGHPUT_UNDER_PROVISIONED",
            .ebs_iops_over_provisioned => "EBS_IOPS_OVER_PROVISIONED",
            .ebs_iops_under_provisioned => "EBS_IOPS_UNDER_PROVISIONED",
            .network_bandwidth_over_provisioned => "NETWORK_BANDWIDTH_OVER_PROVISIONED",
            .network_bandwidth_under_provisioned => "NETWORK_BANDWIDTH_UNDER_PROVISIONED",
            .network_pps_over_provisioned => "NETWORK_PPS_OVER_PROVISIONED",
            .network_pps_under_provisioned => "NETWORK_PPS_UNDER_PROVISIONED",
            .disk_iops_over_provisioned => "DISK_IOPS_OVER_PROVISIONED",
            .disk_iops_under_provisioned => "DISK_IOPS_UNDER_PROVISIONED",
            .disk_throughput_over_provisioned => "DISK_THROUGHPUT_OVER_PROVISIONED",
            .disk_throughput_under_provisioned => "DISK_THROUGHPUT_UNDER_PROVISIONED",
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
