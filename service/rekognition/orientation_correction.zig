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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
