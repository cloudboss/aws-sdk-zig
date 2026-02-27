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

    pub const json_field_names = .{
        .cpu = "CPU",
        .memory = "MEMORY",
        .network_out_bytes_per_second = "NETWORK_OUT_BYTES_PER_SECOND",
        .network_in_bytes_per_second = "NETWORK_IN_BYTES_PER_SECOND",
        .database_connections = "DATABASE_CONNECTIONS",
        .ebs_volume_read_iops = "EBS_VOLUME_READ_IOPS",
        .ebs_volume_write_iops = "EBS_VOLUME_WRITE_IOPS",
        .volume_read_ops_per_second = "VOLUME_READ_OPS_PER_SECOND",
        .volume_write_ops_per_second = "VOLUME_WRITE_OPS_PER_SECOND",
        .active_connection_count = "ACTIVE_CONNECTION_COUNT",
        .packets_in_from_source = "PACKETS_IN_FROM_SOURCE",
        .packets_in_from_destination = "PACKETS_IN_FROM_DESTINATION",
    };
};
