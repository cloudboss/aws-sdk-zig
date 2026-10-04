const std = @import("std");

pub const S3CompressionType = enum {
    none,
    gzip,
    zstd,

    pub const json_field_names = .{
        .none = "NONE",
        .gzip = "GZIP",
        .zstd = "ZSTD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .gzip => "GZIP",
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
