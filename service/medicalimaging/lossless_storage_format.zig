const std = @import("std");

pub const LosslessStorageFormat = enum {
    htj2_k,
    jpeg_2000_lossless,

    pub const json_field_names = .{
        .htj2_k = "HTJ2K",
        .jpeg_2000_lossless = "JPEG_2000_LOSSLESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .htj2_k => "HTJ2K",
            .jpeg_2000_lossless => "JPEG_2000_LOSSLESS",
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
