const std = @import("std");

pub const TileOrder = enum {
    join_sequence,
    speaker_sequence,

    pub const json_field_names = .{
        .join_sequence = "JoinSequence",
        .speaker_sequence = "SpeakerSequence",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .join_sequence => "JoinSequence",
            .speaker_sequence => "SpeakerSequence",
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
