const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cpu_utilization => "CPUUtilization",
            .database_connections => "DatabaseConnections",
            .disk_queue_depth => "DiskQueueDepth",
            .free_storage_space => "FreeStorageSpace",
            .network_receive_throughput => "NetworkReceiveThroughput",
            .network_transmit_throughput => "NetworkTransmitThroughput",
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
