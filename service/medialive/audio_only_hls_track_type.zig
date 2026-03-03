const std = @import("std");

/// Audio Only Hls Track Type
pub const AudioOnlyHlsTrackType = enum {
    alternate_audio_auto_select,
    alternate_audio_auto_select_default,
    alternate_audio_not_auto_select,
    audio_only_variant_stream,

    pub const json_field_names = .{
        .alternate_audio_auto_select = "ALTERNATE_AUDIO_AUTO_SELECT",
        .alternate_audio_auto_select_default = "ALTERNATE_AUDIO_AUTO_SELECT_DEFAULT",
        .alternate_audio_not_auto_select = "ALTERNATE_AUDIO_NOT_AUTO_SELECT",
        .audio_only_variant_stream = "AUDIO_ONLY_VARIANT_STREAM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .alternate_audio_auto_select => "ALTERNATE_AUDIO_AUTO_SELECT",
            .alternate_audio_auto_select_default => "ALTERNATE_AUDIO_AUTO_SELECT_DEFAULT",
            .alternate_audio_not_auto_select => "ALTERNATE_AUDIO_NOT_AUTO_SELECT",
            .audio_only_variant_stream => "AUDIO_ONLY_VARIANT_STREAM",
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
