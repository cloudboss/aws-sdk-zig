const std = @import("std");

/// Av1 Bit Depth
pub const Av1BitDepth = enum {
    depth_10,
    depth_8,

    pub const json_field_names = .{
        .depth_10 = "DEPTH_10",
        .depth_8 = "DEPTH_8",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .depth_10 => "DEPTH_10",
            .depth_8 => "DEPTH_8",
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
