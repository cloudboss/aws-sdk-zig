const std = @import("std");

/// Specify Sample Adaptive Offset (SAO) filter strength. Adaptive mode
/// dynamically selects best strength based on content
pub const H265SampleAdaptiveOffsetFilterMode = enum {
    default,
    adaptive,
    off,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .adaptive = "ADAPTIVE",
        .off = "OFF",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .adaptive => "ADAPTIVE",
            .off => "OFF",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
