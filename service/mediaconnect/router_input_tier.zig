const std = @import("std");

pub const RouterInputTier = enum {
    input_100,
    input_50,
    input_20,

    pub const json_field_names = .{
        .input_100 = "INPUT_100",
        .input_50 = "INPUT_50",
        .input_20 = "INPUT_20",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .input_100 => "INPUT_100",
            .input_50 => "INPUT_50",
            .input_20 => "INPUT_20",
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
