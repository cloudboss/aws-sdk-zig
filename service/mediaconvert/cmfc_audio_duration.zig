const std = @import("std");

/// Specify this setting only when your output will be consumed by a downstream
/// repackaging workflow that is sensitive to very small duration differences
/// between video and audio. For this situation, choose Match video duration. In
/// all other cases, keep the default value, Default codec duration. When you
/// choose Match video duration, MediaConvert pads the output audio streams with
/// silence or trims them to ensure that the total duration of each audio stream
/// is at least as long as the total duration of the video stream. After padding
/// or trimming, the audio stream duration is no more than one frame longer than
/// the video stream. MediaConvert applies audio padding or trimming only to the
/// end of the last segment of the output. For unsegmented outputs, MediaConvert
/// adds padding only to the end of the file. When you keep the default value,
/// any minor discrepancies between audio and video duration will depend on your
/// output audio codec.
pub const CmfcAudioDuration = enum {
    default_codec_duration,
    match_video_duration,

    pub const json_field_names = .{
        .default_codec_duration = "DEFAULT_CODEC_DURATION",
        .match_video_duration = "MATCH_VIDEO_DURATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default_codec_duration => "DEFAULT_CODEC_DURATION",
            .match_video_duration => "MATCH_VIDEO_DURATION",
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
