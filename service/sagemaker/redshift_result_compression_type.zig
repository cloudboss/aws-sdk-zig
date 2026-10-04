const std = @import("std");

/// The compression used for Redshift query results.
pub const RedshiftResultCompressionType = enum {
    none,
    gzip,
    bzip2,
    zstd,
    snappy,

    pub const json_field_names = .{
        .none = "None",
        .gzip = "GZIP",
        .bzip2 = "BZIP2",
        .zstd = "ZSTD",
        .snappy = "SNAPPY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "None",
            .gzip => "GZIP",
            .bzip2 => "BZIP2",
            .zstd => "ZSTD",
            .snappy => "SNAPPY",
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
