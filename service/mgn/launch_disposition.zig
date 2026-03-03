const std = @import("std");

pub const LaunchDisposition = enum {
    stopped,
    started,

    pub const json_field_names = .{
        .stopped = "STOPPED",
        .started = "STARTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .stopped => "STOPPED",
            .started => "STARTED",
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
