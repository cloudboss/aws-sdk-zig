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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
