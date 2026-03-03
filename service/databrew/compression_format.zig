const std = @import("std");

pub const CompressionFormat = enum {
    gzip,
    lz4,
    snappy,
    bzip2,
    deflate,
    lzo,
    brotli,
    zstd,
    zlib,

    pub const json_field_names = .{
        .gzip = "GZIP",
        .lz4 = "LZ4",
        .snappy = "SNAPPY",
        .bzip2 = "BZIP2",
        .deflate = "DEFLATE",
        .lzo = "LZO",
        .brotli = "BROTLI",
        .zstd = "ZSTD",
        .zlib = "ZLIB",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .gzip => "GZIP",
            .lz4 => "LZ4",
            .snappy => "SNAPPY",
            .bzip2 => "BZIP2",
            .deflate => "DEFLATE",
            .lzo => "LZO",
            .brotli => "BROTLI",
            .zstd => "ZSTD",
            .zlib => "ZLIB",
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
