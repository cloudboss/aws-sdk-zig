const std = @import("std");

pub const NdiOutputTimecodeSource = enum {
    embedded_timecode,
    utc_system_time,

    pub const json_field_names = .{
        .embedded_timecode = "EMBEDDED_TIMECODE",
        .utc_system_time = "UTC_SYSTEM_TIME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .embedded_timecode => "EMBEDDED_TIMECODE",
            .utc_system_time => "UTC_SYSTEM_TIME",
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
