const std = @import("std");

/// Choose the loudness measurement mode for your audio content. For music or
/// advertisements: We recommend that you keep the default value, Program. For
/// speech or other content: We recommend that you choose Anchor. When you do,
/// MediaConvert optimizes the loudness of your output for clarify by applying
/// speech gates.
pub const AacLoudnessMeasurementMode = enum {
    program,
    anchor,

    pub const json_field_names = .{
        .program = "PROGRAM",
        .anchor = "ANCHOR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .program => "PROGRAM",
            .anchor => "ANCHOR",
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
