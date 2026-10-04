const std = @import("std");

/// Controls how MediaLive synchronizes Elemental Inference generated subtitles
/// with video output.
///
/// video_aligned_captions - MediaLive delays video to ensure captions are
/// synchronized with
/// audio and video.
/// no_video_delay - MediaLive does not delay video for caption alignment.
/// Captions output
/// timing is adjusted to align with video as captions become available.
pub const CaptionSynchronizationMode = enum {
    no_video_delay,
    video_aligned_captions,

    pub const json_field_names = .{
        .no_video_delay = "NO_VIDEO_DELAY",
        .video_aligned_captions = "VIDEO_ALIGNED_CAPTIONS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_video_delay => "NO_VIDEO_DELAY",
            .video_aligned_captions => "VIDEO_ALIGNED_CAPTIONS",
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
