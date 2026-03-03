const std = @import("std");

pub const TestExecutionModality = enum {
    text,
    audio,

    pub const json_field_names = .{
        .text = "Text",
        .audio = "Audio",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .text => "Text",
            .audio => "Audio",
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
