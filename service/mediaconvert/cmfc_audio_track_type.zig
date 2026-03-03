const std = @import("std");

/// Use this setting to control the values that MediaConvert puts in your HLS
/// parent playlist to control how the client player selects which audio track
/// to play. Choose Audio-only variant stream (AUDIO_ONLY_VARIANT_STREAM) for
/// any variant that you want to prohibit the client from playing with video.
/// This causes MediaConvert to represent the variant as an EXT-X-STREAM-INF in
/// the HLS manifest. The other options for this setting determine the values
/// that MediaConvert writes for the DEFAULT and AUTOSELECT attributes of the
/// EXT-X-MEDIA entry for the audio variant. For more information about these
/// attributes, see the Apple documentation article
/// https://developer.apple.com/documentation/http_live_streaming/example_playlists_for_http_live_streaming/adding_alternate_media_to_a_playlist. Choose Alternate audio, auto select, default to set DEFAULT=YES and AUTOSELECT=YES. Choose this value for only one variant in your output group. Choose Alternate audio, auto select, not default to set DEFAULT=NO and AUTOSELECT=YES. Choose Alternate Audio, Not Auto Select to set DEFAULT=NO and AUTOSELECT=NO. When you don't specify a value for this setting, MediaConvert defaults to Alternate audio, auto select, default. When there is more than one variant in your output group, you must explicitly choose a value for this setting.
pub const CmfcAudioTrackType = enum {
    alternate_audio_auto_select_default,
    alternate_audio_auto_select,
    alternate_audio_not_auto_select,
    audio_only_variant_stream,

    pub const json_field_names = .{
        .alternate_audio_auto_select_default = "ALTERNATE_AUDIO_AUTO_SELECT_DEFAULT",
        .alternate_audio_auto_select = "ALTERNATE_AUDIO_AUTO_SELECT",
        .alternate_audio_not_auto_select = "ALTERNATE_AUDIO_NOT_AUTO_SELECT",
        .audio_only_variant_stream = "AUDIO_ONLY_VARIANT_STREAM",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .alternate_audio_auto_select_default => "ALTERNATE_AUDIO_AUTO_SELECT_DEFAULT",
            .alternate_audio_auto_select => "ALTERNATE_AUDIO_AUTO_SELECT",
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
