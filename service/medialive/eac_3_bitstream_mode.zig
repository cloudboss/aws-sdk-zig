const std = @import("std");

/// Eac3 Bitstream Mode
pub const Eac3BitstreamMode = enum {
    commentary,
    complete_main,
    emergency,
    hearing_impaired,
    visually_impaired,

    pub const json_field_names = .{
        .commentary = "COMMENTARY",
        .complete_main = "COMPLETE_MAIN",
        .emergency = "EMERGENCY",
        .hearing_impaired = "HEARING_IMPAIRED",
        .visually_impaired = "VISUALLY_IMPAIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .commentary => "COMMENTARY",
            .complete_main => "COMPLETE_MAIN",
            .emergency => "EMERGENCY",
            .hearing_impaired => "HEARING_IMPAIRED",
            .visually_impaired => "VISUALLY_IMPAIRED",
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
