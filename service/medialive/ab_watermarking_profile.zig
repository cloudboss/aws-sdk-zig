const std = @import("std");

/// Ab Watermarking Profile
pub const AbWatermarkingProfile = enum {
    camcording,
    custom,
    default,
    hq,
    mezzanine,
    robust,

    pub const json_field_names = .{
        .camcording = "CAMCORDING",
        .custom = "CUSTOM",
        .default = "DEFAULT",
        .hq = "HQ",
        .mezzanine = "MEZZANINE",
        .robust = "ROBUST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .camcording => "CAMCORDING",
            .custom => "CUSTOM",
            .default => "DEFAULT",
            .hq => "HQ",
            .mezzanine => "MEZZANINE",
            .robust => "ROBUST",
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
