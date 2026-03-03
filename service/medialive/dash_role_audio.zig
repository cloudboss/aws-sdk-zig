const std = @import("std");

/// Dash Role Audio
pub const DashRoleAudio = enum {
    alternate,
    commentary,
    description,
    dub,
    emergency,
    enhanced_audio_intelligibility,
    karaoke,
    main,
    supplementary,

    pub const json_field_names = .{
        .alternate = "ALTERNATE",
        .commentary = "COMMENTARY",
        .description = "DESCRIPTION",
        .dub = "DUB",
        .emergency = "EMERGENCY",
        .enhanced_audio_intelligibility = "ENHANCED-AUDIO-INTELLIGIBILITY",
        .karaoke = "KARAOKE",
        .main = "MAIN",
        .supplementary = "SUPPLEMENTARY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .alternate => "ALTERNATE",
            .commentary => "COMMENTARY",
            .description => "DESCRIPTION",
            .dub => "DUB",
            .emergency => "EMERGENCY",
            .enhanced_audio_intelligibility => "ENHANCED-AUDIO-INTELLIGIBILITY",
            .karaoke => "KARAOKE",
            .main => "MAIN",
            .supplementary => "SUPPLEMENTARY",
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
