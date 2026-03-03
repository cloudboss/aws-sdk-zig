const std = @import("std");

/// If the sample range metadata in your input video is accurate, or if you
/// don't know about sample range, keep the default value, Follow, for this
/// setting. When you do, the service automatically detects your input sample
/// range. If your input video has metadata indicating the wrong sample range,
/// specify the accurate sample range here. When you do, MediaConvert ignores
/// any sample range information in the input metadata. Regardless of whether
/// MediaConvert uses the input sample range or the sample range that you
/// specify, MediaConvert uses the sample range for transcoding and also writes
/// it to the output metadata.
pub const InputSampleRange = enum {
    follow,
    full_range,
    limited_range,

    pub const json_field_names = .{
        .follow = "FOLLOW",
        .full_range = "FULL_RANGE",
        .limited_range = "LIMITED_RANGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .follow => "FOLLOW",
            .full_range => "FULL_RANGE",
            .limited_range => "LIMITED_RANGE",
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
