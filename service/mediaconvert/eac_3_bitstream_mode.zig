const std = @import("std");

/// Specify the bitstream mode for the E-AC-3 stream that the encoder emits. For
/// more information about the EAC3 bitstream mode, see ATSC A/52-2012 (Annex
/// E).
pub const Eac3BitstreamMode = enum {
    complete_main,
    commentary,
    emergency,
    hearing_impaired,
    visually_impaired,

    pub const json_field_names = .{
        .complete_main = "COMPLETE_MAIN",
        .commentary = "COMMENTARY",
        .emergency = "EMERGENCY",
        .hearing_impaired = "HEARING_IMPAIRED",
        .visually_impaired = "VISUALLY_IMPAIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .complete_main => "COMPLETE_MAIN",
            .commentary => "COMMENTARY",
            .emergency => "EMERGENCY",
            .hearing_impaired => "HEARING_IMPAIRED",
            .visually_impaired => "VISUALLY_IMPAIRED",
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
