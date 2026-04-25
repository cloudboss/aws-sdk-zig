const std = @import("std");

/// Specify the video Scaling behavior when your output has a different
/// resolution than your input. For more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/video-scaling.html Select
/// Smart Cropping using Elemental Inference as your scaling behavior to have
/// Elemental Inference automatically crop your video. Smart Crop requires a
/// vertical output aspect ratio (1:1 is the widest aspect ratio supported).
pub const ScalingBehavior = enum {
    default,
    stretch_to_output,
    fit,
    fit_no_upscale,
    fill,
    smart_crop,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .stretch_to_output = "STRETCH_TO_OUTPUT",
        .fit = "FIT",
        .fit_no_upscale = "FIT_NO_UPSCALE",
        .fill = "FILL",
        .smart_crop = "SMART_CROP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .stretch_to_output => "STRETCH_TO_OUTPUT",
            .fit => "FIT",
            .fit_no_upscale => "FIT_NO_UPSCALE",
            .fill => "FILL",
            .smart_crop => "SMART_CROP",
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
