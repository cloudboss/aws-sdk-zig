const std = @import("std");

pub const IdleMetricName = enum {
    cpu,
    memory,
    network_out_bytes_per_second,
    network_in_bytes_per_second,
    database_connections,
    ebs_volume_read_iops,
    ebs_volume_write_iops,
    volume_read_ops_per_second,
    volume_write_ops_per_second,
    active_connection_count,
    packets_in_from_source,
    packets_in_from_destination,
    consumed_read_capacity_units,
    consumed_write_capacity_units,
    consumed_change_data_capture_units,
    new_connections,
    engine_cpu_utilization,
    cache_hits,
    cache_misses,
    keyspace_hits,
    keyspace_misses,
    is_idle,
    user_connected,
    invocations,
    get_type_cmds,
    set_type_cmds,
    elasti_cache_processing_units,
    curr_connections,

    pub const json_field_names = .{
        .cpu = "CPU",
        .memory = "Memory",
        .network_out_bytes_per_second = "NetworkOutBytesPerSecond",
        .network_in_bytes_per_second = "NetworkInBytesPerSecond",
        .database_connections = "DatabaseConnections",
        .ebs_volume_read_iops = "EBSVolumeReadIOPS",
        .ebs_volume_write_iops = "EBSVolumeWriteIOPS",
        .volume_read_ops_per_second = "VolumeReadOpsPerSecond",
        .volume_write_ops_per_second = "VolumeWriteOpsPerSecond",
        .active_connection_count = "ActiveConnectionCount",
        .packets_in_from_source = "PacketsInFromSource",
        .packets_in_from_destination = "PacketsInFromDestination",
        .consumed_read_capacity_units = "ConsumedReadCapacityUnits",
        .consumed_write_capacity_units = "ConsumedWriteCapacityUnits",
        .consumed_change_data_capture_units = "ConsumedChangeDataCaptureUnits",
        .new_connections = "NewConnections",
        .engine_cpu_utilization = "EngineCPUUtilization",
        .cache_hits = "CacheHits",
        .cache_misses = "CacheMisses",
        .keyspace_hits = "KeyspaceHits",
        .keyspace_misses = "KeyspaceMisses",
        .is_idle = "IsIdle",
        .user_connected = "UserConnected",
        .invocations = "Invocations",
        .get_type_cmds = "GetTypeCmds",
        .set_type_cmds = "SetTypeCmds",
        .elasti_cache_processing_units = "ElastiCacheProcessingUnits",
        .curr_connections = "CurrConnections",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cpu => "CPU",
            .memory => "Memory",
            .network_out_bytes_per_second => "NetworkOutBytesPerSecond",
            .network_in_bytes_per_second => "NetworkInBytesPerSecond",
            .database_connections => "DatabaseConnections",
            .ebs_volume_read_iops => "EBSVolumeReadIOPS",
            .ebs_volume_write_iops => "EBSVolumeWriteIOPS",
            .volume_read_ops_per_second => "VolumeReadOpsPerSecond",
            .volume_write_ops_per_second => "VolumeWriteOpsPerSecond",
            .active_connection_count => "ActiveConnectionCount",
            .packets_in_from_source => "PacketsInFromSource",
            .packets_in_from_destination => "PacketsInFromDestination",
            .consumed_read_capacity_units => "ConsumedReadCapacityUnits",
            .consumed_write_capacity_units => "ConsumedWriteCapacityUnits",
            .consumed_change_data_capture_units => "ConsumedChangeDataCaptureUnits",
            .new_connections => "NewConnections",
            .engine_cpu_utilization => "EngineCPUUtilization",
            .cache_hits => "CacheHits",
            .cache_misses => "CacheMisses",
            .keyspace_hits => "KeyspaceHits",
            .keyspace_misses => "KeyspaceMisses",
            .is_idle => "IsIdle",
            .user_connected => "UserConnected",
            .invocations => "Invocations",
            .get_type_cmds => "GetTypeCmds",
            .set_type_cmds => "SetTypeCmds",
            .elasti_cache_processing_units => "ElastiCacheProcessingUnits",
            .curr_connections => "CurrConnections",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
