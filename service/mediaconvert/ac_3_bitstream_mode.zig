const std = @import("std");

/// Specify the bitstream mode for the AC-3 stream that the encoder emits. For
/// more information about the AC3 bitstream mode, see ATSC A/52-2012 (Annex E).
pub const Ac3BitstreamMode = enum {
    complete_main,
    commentary,
    dialogue,
    emergency,
    hearing_impaired,
    music_and_effects,
    visually_impaired,
    voice_over,

    pub const json_field_names = .{
        .complete_main = "COMPLETE_MAIN",
        .commentary = "COMMENTARY",
        .dialogue = "DIALOGUE",
        .emergency = "EMERGENCY",
        .hearing_impaired = "HEARING_IMPAIRED",
        .music_and_effects = "MUSIC_AND_EFFECTS",
        .visually_impaired = "VISUALLY_IMPAIRED",
        .voice_over = "VOICE_OVER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .complete_main => "COMPLETE_MAIN",
            .commentary => "COMMENTARY",
            .dialogue => "DIALOGUE",
            .emergency => "EMERGENCY",
            .hearing_impaired => "HEARING_IMPAIRED",
            .music_and_effects => "MUSIC_AND_EFFECTS",
            .visually_impaired => "VISUALLY_IMPAIRED",
            .voice_over => "VOICE_OVER",
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
