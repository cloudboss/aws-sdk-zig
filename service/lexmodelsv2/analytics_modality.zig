const std = @import("std");

pub const AnalyticsModality = enum {
    speech,
    text,
    dtmf,
    multi_mode,

    pub const json_field_names = .{
        .speech = "Speech",
        .text = "Text",
        .dtmf = "DTMF",
        .multi_mode = "MultiMode",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .speech => "Speech",
            .text => "Text",
            .dtmf => "DTMF",
            .multi_mode => "MultiMode",
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
