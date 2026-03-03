const std = @import("std");

/// Smooth Group Segmentation Mode
pub const SmoothGroupSegmentationMode = enum {
    use_input_segmentation,
    use_segment_duration,

    pub const json_field_names = .{
        .use_input_segmentation = "USE_INPUT_SEGMENTATION",
        .use_segment_duration = "USE_SEGMENT_DURATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .use_input_segmentation => "USE_INPUT_SEGMENTATION",
            .use_segment_duration => "USE_SEGMENT_DURATION",
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
