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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
