const std = @import("std");

pub const OrientationCorrection = enum {
    rotate_0,
    rotate_90,
    rotate_180,
    rotate_270,

    pub const json_field_names = .{
        .rotate_0 = "ROTATE_0",
        .rotate_90 = "ROTATE_90",
        .rotate_180 = "ROTATE_180",
        .rotate_270 = "ROTATE_270",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rotate_0 => "ROTATE_0",
            .rotate_90 => "ROTATE_90",
            .rotate_180 => "ROTATE_180",
            .rotate_270 => "ROTATE_270",
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
