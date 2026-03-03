const std = @import("std");

/// Hls Iv Source
pub const HlsIvSource = enum {
    explicit,
    follows_segment_number,

    pub const json_field_names = .{
        .explicit = "EXPLICIT",
        .follows_segment_number = "FOLLOWS_SEGMENT_NUMBER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .explicit => "EXPLICIT",
            .follows_segment_number => "FOLLOWS_SEGMENT_NUMBER",
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
