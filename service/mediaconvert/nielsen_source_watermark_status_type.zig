const std = @import("std");

/// Required. Specify whether your source content already contains Nielsen
/// non-linear watermarks. When you set this value to Watermarked, the service
/// fails the job. Nielsen requires that you add non-linear watermarking to only
/// clean content that doesn't already have non-linear Nielsen watermarks.
pub const NielsenSourceWatermarkStatusType = enum {
    clean,
    watermarked,

    pub const json_field_names = .{
        .clean = "CLEAN",
        .watermarked = "WATERMARKED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .clean => "CLEAN",
            .watermarked => "WATERMARKED",
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
