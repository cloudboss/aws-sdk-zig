const std = @import("std");

pub const RDSDBMetricName = enum {
    cpu,
    memory,
    ebs_volume_storage_space_utilization,
    network_receive_throughput,
    network_transmit_throughput,
    ebs_volume_read_iops,
    ebs_volume_write_iops,
    ebs_volume_read_throughput,
    ebs_volume_write_throughput,
    database_connections,
    storage_network_receive_throughput,
    storage_network_transmit_throughput,
    aurora_memory_health_state,
    aurora_memory_num_declined_sql,
    aurora_memory_num_kill_conn_total,
    aurora_memory_num_kill_query_total,
    read_iops_ephemeral_storage,
    write_iops_ephemeral_storage,
    volume_read_iops,
    volume_bytes_used,
    volume_write_iops,

    pub const json_field_names = .{
        .cpu = "CPU",
        .memory = "Memory",
        .ebs_volume_storage_space_utilization = "EBSVolumeStorageSpaceUtilization",
        .network_receive_throughput = "NetworkReceiveThroughput",
        .network_transmit_throughput = "NetworkTransmitThroughput",
        .ebs_volume_read_iops = "EBSVolumeReadIOPS",
        .ebs_volume_write_iops = "EBSVolumeWriteIOPS",
        .ebs_volume_read_throughput = "EBSVolumeReadThroughput",
        .ebs_volume_write_throughput = "EBSVolumeWriteThroughput",
        .database_connections = "DatabaseConnections",
        .storage_network_receive_throughput = "StorageNetworkReceiveThroughput",
        .storage_network_transmit_throughput = "StorageNetworkTransmitThroughput",
        .aurora_memory_health_state = "AuroraMemoryHealthState",
        .aurora_memory_num_declined_sql = "AuroraMemoryNumDeclinedSql",
        .aurora_memory_num_kill_conn_total = "AuroraMemoryNumKillConnTotal",
        .aurora_memory_num_kill_query_total = "AuroraMemoryNumKillQueryTotal",
        .read_iops_ephemeral_storage = "ReadIOPSEphemeralStorage",
        .write_iops_ephemeral_storage = "WriteIOPSEphemeralStorage",
        .volume_read_iops = "VolumeReadIOPs",
        .volume_bytes_used = "VolumeBytesUsed",
        .volume_write_iops = "VolumeWriteIOPs",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cpu => "CPU",
            .memory => "Memory",
            .ebs_volume_storage_space_utilization => "EBSVolumeStorageSpaceUtilization",
            .network_receive_throughput => "NetworkReceiveThroughput",
            .network_transmit_throughput => "NetworkTransmitThroughput",
            .ebs_volume_read_iops => "EBSVolumeReadIOPS",
            .ebs_volume_write_iops => "EBSVolumeWriteIOPS",
            .ebs_volume_read_throughput => "EBSVolumeReadThroughput",
            .ebs_volume_write_throughput => "EBSVolumeWriteThroughput",
            .database_connections => "DatabaseConnections",
            .storage_network_receive_throughput => "StorageNetworkReceiveThroughput",
            .storage_network_transmit_throughput => "StorageNetworkTransmitThroughput",
            .aurora_memory_health_state => "AuroraMemoryHealthState",
            .aurora_memory_num_declined_sql => "AuroraMemoryNumDeclinedSql",
            .aurora_memory_num_kill_conn_total => "AuroraMemoryNumKillConnTotal",
            .aurora_memory_num_kill_query_total => "AuroraMemoryNumKillQueryTotal",
            .read_iops_ephemeral_storage => "ReadIOPSEphemeralStorage",
            .write_iops_ephemeral_storage => "WriteIOPSEphemeralStorage",
            .volume_read_iops => "VolumeReadIOPs",
            .volume_bytes_used => "VolumeBytesUsed",
            .volume_write_iops => "VolumeWriteIOPs",
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
