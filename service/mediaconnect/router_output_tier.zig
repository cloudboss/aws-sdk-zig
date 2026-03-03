const std = @import("std");

pub const RouterOutputTier = enum {
    output_100,
    output_50,
    output_20,

    pub const json_field_names = .{
        .output_100 = "OUTPUT_100",
        .output_50 = "OUTPUT_50",
        .output_20 = "OUTPUT_20",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .output_100 => "OUTPUT_100",
            .output_50 => "OUTPUT_50",
            .output_20 => "OUTPUT_20",
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
