const std = @import("std");

/// M2ts Absent Input Audio Behavior
pub const M2tsAbsentInputAudioBehavior = enum {
    drop,
    encode_silence,

    pub const json_field_names = .{
        .drop = "DROP",
        .encode_silence = "ENCODE_SILENCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .drop => "DROP",
            .encode_silence => "ENCODE_SILENCE",
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
