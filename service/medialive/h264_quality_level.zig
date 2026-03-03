const std = @import("std");

/// H264 Quality Level
pub const H264QualityLevel = enum {
    enhanced_quality,
    standard_quality,

    pub const json_field_names = .{
        .enhanced_quality = "ENHANCED_QUALITY",
        .standard_quality = "STANDARD_QUALITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enhanced_quality => "ENHANCED_QUALITY",
            .standard_quality => "STANDARD_QUALITY",
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
