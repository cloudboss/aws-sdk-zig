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
