const std = @import("std");

pub const CompressionFormat = enum {
    uncompressed,
    gzip,
    zip,
    snappy,
    hadoop_snappy,

    pub const json_field_names = .{
        .uncompressed = "UNCOMPRESSED",
        .gzip = "GZIP",
        .zip = "ZIP",
        .snappy = "Snappy",
        .hadoop_snappy = "HADOOP_SNAPPY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .uncompressed => "UNCOMPRESSED",
            .gzip => "GZIP",
            .zip => "ZIP",
            .snappy => "Snappy",
            .hadoop_snappy => "HADOOP_SNAPPY",
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
