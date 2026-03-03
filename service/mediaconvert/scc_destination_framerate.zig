const std = @import("std");

/// Set Framerate to make sure that the captions and the video are synchronized
/// in the output. Specify a frame rate that matches the frame rate of the
/// associated video. If the video frame rate is 29.97, choose 29.97 dropframe
/// only if the video has video_insertion=true and drop_frame_timecode=true;
/// otherwise, choose 29.97 non-dropframe.
pub const SccDestinationFramerate = enum {
    framerate_23_97,
    framerate_24,
    framerate_25,
    framerate_29_97_dropframe,
    framerate_29_97_non_dropframe,

    pub const json_field_names = .{
        .framerate_23_97 = "FRAMERATE_23_97",
        .framerate_24 = "FRAMERATE_24",
        .framerate_25 = "FRAMERATE_25",
        .framerate_29_97_dropframe = "FRAMERATE_29_97_DROPFRAME",
        .framerate_29_97_non_dropframe = "FRAMERATE_29_97_NON_DROPFRAME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .framerate_23_97 => "FRAMERATE_23_97",
            .framerate_24 => "FRAMERATE_24",
            .framerate_25 => "FRAMERATE_25",
            .framerate_29_97_dropframe => "FRAMERATE_29_97_DROPFRAME",
            .framerate_29_97_non_dropframe => "FRAMERATE_29_97_NON_DROPFRAME",
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
