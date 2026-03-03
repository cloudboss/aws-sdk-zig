const std = @import("std");

/// The type of compression to use producing records to the target cluster.
pub const TargetCompressionType = enum {
    none,
    gzip,
    snappy,
    lz4,
    zstd,

    pub const json_field_names = .{
        .none = "NONE",
        .gzip = "GZIP",
        .snappy = "SNAPPY",
        .lz4 = "LZ4",
        .zstd = "ZSTD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .gzip => "GZIP",
            .snappy => "SNAPPY",
            .lz4 => "LZ4",
            .zstd => "ZSTD",
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
