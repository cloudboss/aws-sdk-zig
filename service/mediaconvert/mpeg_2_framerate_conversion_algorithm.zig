const std = @import("std");

/// Choose the method that you want MediaConvert to use when increasing or
/// decreasing your video's frame rate. For numerically simple conversions, such
/// as 60 fps to 30 fps: We recommend that you keep the default value, Drop
/// duplicate. For numerically complex conversions, to avoid stutter: Choose
/// Interpolate. This results in a smooth picture, but might introduce
/// undesirable video artifacts. For complex frame rate conversions, especially
/// if your source video has already been converted from its original cadence:
/// Choose FrameFormer to do motion-compensated interpolation. FrameFormer uses
/// the best conversion method frame by frame. Note that using FrameFormer
/// increases the transcoding time and incurs a significant add-on cost. When
/// you choose FrameFormer, your input video resolution must be at least 128x96.
/// To create an output with the same number of frames as your input: Choose
/// Maintain frame count. When you do, MediaConvert will not drop, interpolate,
/// add, or otherwise change the frame count from your input to your output.
/// Note that since the frame count is maintained, the duration of your output
/// will become shorter at higher frame rates and longer at lower frame rates.
pub const Mpeg2FramerateConversionAlgorithm = enum {
    duplicate_drop,
    interpolate,
    frameformer,
    maintain_frame_count,

    pub const json_field_names = .{
        .duplicate_drop = "DUPLICATE_DROP",
        .interpolate = "INTERPOLATE",
        .frameformer = "FRAMEFORMER",
        .maintain_frame_count = "MAINTAIN_FRAME_COUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .duplicate_drop => "DUPLICATE_DROP",
            .interpolate => "INTERPOLATE",
            .frameformer => "FRAMEFORMER",
            .maintain_frame_count => "MAINTAIN_FRAME_COUNT",
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
