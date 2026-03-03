const std = @import("std");

pub const RunningMode = enum {
    auto_stop,
    always_on,
    manual,

    pub const json_field_names = .{
        .auto_stop = "AUTO_STOP",
        .always_on = "ALWAYS_ON",
        .manual = "MANUAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto_stop => "AUTO_STOP",
            .always_on => "ALWAYS_ON",
            .manual => "MANUAL",
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
