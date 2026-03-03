const std = @import("std");

/// The compression used for Athena query results.
pub const AthenaResultCompressionType = enum {
    gzip,
    snappy,
    zlib,

    pub const json_field_names = .{
        .gzip = "GZIP",
        .snappy = "SNAPPY",
        .zlib = "ZLIB",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .gzip => "GZIP",
            .snappy => "SNAPPY",
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
