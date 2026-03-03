const std = @import("std");

pub const InputMode = enum {
    text,
    speech,
    dtmf,

    pub const json_field_names = .{
        .text = "Text",
        .speech = "Speech",
        .dtmf = "DTMF",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .text => "Text",
            .speech => "Speech",
            .dtmf => "DTMF",
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
