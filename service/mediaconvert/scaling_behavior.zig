const std = @import("std");

/// Specify the video Scaling behavior when your output has a different
/// resolution than your input. For more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/video-scaling.html
pub const ScalingBehavior = enum {
    default,
    stretch_to_output,
    fit,
    fit_no_upscale,
    fill,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .stretch_to_output = "STRETCH_TO_OUTPUT",
        .fit = "FIT",
        .fit_no_upscale = "FIT_NO_UPSCALE",
        .fill = "FILL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .stretch_to_output => "STRETCH_TO_OUTPUT",
            .fit => "FIT",
            .fit_no_upscale => "FIT_NO_UPSCALE",
            .fill => "FILL",
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
