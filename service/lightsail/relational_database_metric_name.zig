pub const RelationalDatabaseMetricName = enum {
    cpu_utilization,
    database_connections,
    disk_queue_depth,
    free_storage_space,
    network_receive_throughput,
    network_transmit_throughput,

    pub const json_field_names = .{
        .cpu_utilization = "CPUUtilization",
        .database_connections = "DatabaseConnections",
        .disk_queue_depth = "DiskQueueDepth",
        .free_storage_space = "FreeStorageSpace",
        .network_receive_throughput = "NetworkReceiveThroughput",
        .network_transmit_throughput = "NetworkTransmitThroughput",
    };
};
