const std = @import("std");

pub const ParquetCompressionType = enum {
    snappy,
    lzo,
    gzip,
    brotli,
    lz4,
    uncompressed,
    none,

    pub const json_field_names = .{
        .snappy = "snappy",
        .lzo = "lzo",
        .gzip = "gzip",
        .brotli = "brotli",
        .lz4 = "lz4",
        .uncompressed = "uncompressed",
        .none = "none",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .snappy => "snappy",
            .lzo => "lzo",
            .gzip => "gzip",
            .brotli => "brotli",
            .lz4 => "lz4",
            .uncompressed => "uncompressed",
            .none => "none",
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
