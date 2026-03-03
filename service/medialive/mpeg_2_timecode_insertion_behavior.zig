const std = @import("std");

/// Mpeg2 Timecode Insertion Behavior
pub const Mpeg2TimecodeInsertionBehavior = enum {
    disabled,
    gop_timecode,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .gop_timecode = "GOP_TIMECODE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .gop_timecode => "GOP_TIMECODE",
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
