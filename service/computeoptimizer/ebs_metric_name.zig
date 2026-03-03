const std = @import("std");

pub const EBSMetricName = enum {
    volume_read_ops_per_second,
    volume_write_ops_per_second,
    volume_read_bytes_per_second,
    volume_write_bytes_per_second,

    pub const json_field_names = .{
        .volume_read_ops_per_second = "VolumeReadOpsPerSecond",
        .volume_write_ops_per_second = "VolumeWriteOpsPerSecond",
        .volume_read_bytes_per_second = "VolumeReadBytesPerSecond",
        .volume_write_bytes_per_second = "VolumeWriteBytesPerSecond",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .volume_read_ops_per_second => "VolumeReadOpsPerSecond",
            .volume_write_ops_per_second => "VolumeWriteOpsPerSecond",
            .volume_read_bytes_per_second => "VolumeReadBytesPerSecond",
            .volume_write_bytes_per_second => "VolumeWriteBytesPerSecond",
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
