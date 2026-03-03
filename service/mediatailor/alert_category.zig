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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
