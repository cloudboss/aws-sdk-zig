const std = @import("std");

/// Selects which PIDs to place EBP markers on. They can either be placed only
/// on the video PID, or on both the video PID and all audio PIDs. Only
/// applicable when EBP segmentation markers are is selected
/// (segmentationMarkers is EBP or EBP_LEGACY).
pub const M2tsEbpPlacement = enum {
    video_and_audio_pids,
    video_pid,

    pub const json_field_names = .{
        .video_and_audio_pids = "VIDEO_AND_AUDIO_PIDS",
        .video_pid = "VIDEO_PID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .video_and_audio_pids => "VIDEO_AND_AUDIO_PIDS",
            .video_pid => "VIDEO_PID",
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
