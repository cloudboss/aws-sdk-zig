const std = @import("std");

pub const AlertCategory = enum {
    scheduling_error,
    playback_warning,
    info,

    pub const json_field_names = .{
        .scheduling_error = "SCHEDULING_ERROR",
        .playback_warning = "PLAYBACK_WARNING",
        .info = "INFO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scheduling_error => "SCHEDULING_ERROR",
            .playback_warning => "PLAYBACK_WARNING",
            .info => "INFO",
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
