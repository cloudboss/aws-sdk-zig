const std = @import("std");

pub const RDSInstanceFindingReasonCode = enum {
    cpu_over_provisioned,
    network_bandwidth_over_provisioned,
    ebs_iops_over_provisioned,
    ebs_iops_under_provisioned,
    ebs_throughput_over_provisioned,
    cpu_under_provisioned,
    network_bandwidth_under_provisioned,
    ebs_throughput_under_provisioned,
    new_generation_db_instance_class_available,
    new_engine_version_available,
    db_cluster_writer_under_provisioned,
    memory_under_provisioned,
    instance_storage_read_iops_under_provisioned,
    instance_storage_write_iops_under_provisioned,

    pub const json_field_names = .{
        .cpu_over_provisioned = "CPUOverprovisioned",
        .network_bandwidth_over_provisioned = "NetworkBandwidthOverprovisioned",
        .ebs_iops_over_provisioned = "EBSIOPSOverprovisioned",
        .ebs_iops_under_provisioned = "EBSIOPSUnderprovisioned",
        .ebs_throughput_over_provisioned = "EBSThroughputOverprovisioned",
        .cpu_under_provisioned = "CPUUnderprovisioned",
        .network_bandwidth_under_provisioned = "NetworkBandwidthUnderprovisioned",
        .ebs_throughput_under_provisioned = "EBSThroughputUnderprovisioned",
        .new_generation_db_instance_class_available = "NewGenerationDBInstanceClassAvailable",
        .new_engine_version_available = "NewEngineVersionAvailable",
        .db_cluster_writer_under_provisioned = "DBClusterWriterUnderprovisioned",
        .memory_under_provisioned = "MemoryUnderprovisioned",
        .instance_storage_read_iops_under_provisioned = "InstanceStorageReadIOPSUnderprovisioned",
        .instance_storage_write_iops_under_provisioned = "InstanceStorageWriteIOPSUnderprovisioned",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cpu_over_provisioned => "CPUOverprovisioned",
            .network_bandwidth_over_provisioned => "NetworkBandwidthOverprovisioned",
            .ebs_iops_over_provisioned => "EBSIOPSOverprovisioned",
            .ebs_iops_under_provisioned => "EBSIOPSUnderprovisioned",
            .ebs_throughput_over_provisioned => "EBSThroughputOverprovisioned",
            .cpu_under_provisioned => "CPUUnderprovisioned",
            .network_bandwidth_under_provisioned => "NetworkBandwidthUnderprovisioned",
            .ebs_throughput_under_provisioned => "EBSThroughputUnderprovisioned",
            .new_generation_db_instance_class_available => "NewGenerationDBInstanceClassAvailable",
            .new_engine_version_available => "NewEngineVersionAvailable",
            .db_cluster_writer_under_provisioned => "DBClusterWriterUnderprovisioned",
            .memory_under_provisioned => "MemoryUnderprovisioned",
            .instance_storage_read_iops_under_provisioned => "InstanceStorageReadIOPSUnderprovisioned",
            .instance_storage_write_iops_under_provisioned => "InstanceStorageWriteIOPSUnderprovisioned",
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
