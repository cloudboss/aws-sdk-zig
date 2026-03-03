const std = @import("std");

pub const InstanceRecommendationFindingReasonCode = enum {
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
    gpu_under_provisioned,
    gpu_over_provisioned,
    gpu_memory_under_provisioned,
    gpu_memory_over_provisioned,

    pub const json_field_names = .{
        .cpu_over_provisioned = "CPUOverprovisioned",
        .cpu_under_provisioned = "CPUUnderprovisioned",
        .memory_over_provisioned = "MemoryOverprovisioned",
        .memory_under_provisioned = "MemoryUnderprovisioned",
        .ebs_throughput_over_provisioned = "EBSThroughputOverprovisioned",
        .ebs_throughput_under_provisioned = "EBSThroughputUnderprovisioned",
        .ebs_iops_over_provisioned = "EBSIOPSOverprovisioned",
        .ebs_iops_under_provisioned = "EBSIOPSUnderprovisioned",
        .network_bandwidth_over_provisioned = "NetworkBandwidthOverprovisioned",
        .network_bandwidth_under_provisioned = "NetworkBandwidthUnderprovisioned",
        .network_pps_over_provisioned = "NetworkPPSOverprovisioned",
        .network_pps_under_provisioned = "NetworkPPSUnderprovisioned",
        .disk_iops_over_provisioned = "DiskIOPSOverprovisioned",
        .disk_iops_under_provisioned = "DiskIOPSUnderprovisioned",
        .disk_throughput_over_provisioned = "DiskThroughputOverprovisioned",
        .disk_throughput_under_provisioned = "DiskThroughputUnderprovisioned",
        .gpu_under_provisioned = "GPUUnderprovisioned",
        .gpu_over_provisioned = "GPUOverprovisioned",
        .gpu_memory_under_provisioned = "GPUMemoryUnderprovisioned",
        .gpu_memory_over_provisioned = "GPUMemoryOverprovisioned",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cpu_over_provisioned => "CPUOverprovisioned",
            .cpu_under_provisioned => "CPUUnderprovisioned",
            .memory_over_provisioned => "MemoryOverprovisioned",
            .memory_under_provisioned => "MemoryUnderprovisioned",
            .ebs_throughput_over_provisioned => "EBSThroughputOverprovisioned",
            .ebs_throughput_under_provisioned => "EBSThroughputUnderprovisioned",
            .ebs_iops_over_provisioned => "EBSIOPSOverprovisioned",
            .ebs_iops_under_provisioned => "EBSIOPSUnderprovisioned",
            .network_bandwidth_over_provisioned => "NetworkBandwidthOverprovisioned",
            .network_bandwidth_under_provisioned => "NetworkBandwidthUnderprovisioned",
            .network_pps_over_provisioned => "NetworkPPSOverprovisioned",
            .network_pps_under_provisioned => "NetworkPPSUnderprovisioned",
            .disk_iops_over_provisioned => "DiskIOPSOverprovisioned",
            .disk_iops_under_provisioned => "DiskIOPSUnderprovisioned",
            .disk_throughput_over_provisioned => "DiskThroughputOverprovisioned",
            .disk_throughput_under_provisioned => "DiskThroughputUnderprovisioned",
            .gpu_under_provisioned => "GPUUnderprovisioned",
            .gpu_over_provisioned => "GPUOverprovisioned",
            .gpu_memory_under_provisioned => "GPUMemoryUnderprovisioned",
            .gpu_memory_over_provisioned => "GPUMemoryOverprovisioned",
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
