const std = @import("std");

/// Enable this setting to insert I-frames at scene changes that the service
/// automatically detects. This improves video quality and is enabled by
/// default. If this output uses QVBR, choose Transition detection for further
/// video quality improvement. For more information about QVBR, see
/// https://docs.aws.amazon.com/console/mediaconvert/cbr-vbr-qvbr.
pub const H264SceneChangeDetect = enum {
    disabled,
    enabled,
    transition_detection,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
        .transition_detection = "TRANSITION_DETECTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .enabled => "ENABLED",
            .transition_detection => "TRANSITION_DETECTION",
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
