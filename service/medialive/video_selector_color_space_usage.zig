const std = @import("std");

/// Video Selector Color Space Usage
pub const VideoSelectorColorSpaceUsage = enum {
    fallback,
    force,

    pub const json_field_names = .{
        .fallback = "FALLBACK",
        .force = "FORCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fallback => "FALLBACK",
            .force => "FORCE",
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
