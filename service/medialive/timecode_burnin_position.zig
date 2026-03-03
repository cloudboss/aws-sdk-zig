const std = @import("std");

/// Timecode Burnin Position
pub const TimecodeBurninPosition = enum {
    bottom_center,
    bottom_left,
    bottom_right,
    middle_center,
    middle_left,
    middle_right,
    top_center,
    top_left,
    top_right,

    pub const json_field_names = .{
        .bottom_center = "BOTTOM_CENTER",
        .bottom_left = "BOTTOM_LEFT",
        .bottom_right = "BOTTOM_RIGHT",
        .middle_center = "MIDDLE_CENTER",
        .middle_left = "MIDDLE_LEFT",
        .middle_right = "MIDDLE_RIGHT",
        .top_center = "TOP_CENTER",
        .top_left = "TOP_LEFT",
        .top_right = "TOP_RIGHT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bottom_center => "BOTTOM_CENTER",
            .bottom_left => "BOTTOM_LEFT",
            .bottom_right => "BOTTOM_RIGHT",
            .middle_center => "MIDDLE_CENTER",
            .middle_left => "MIDDLE_LEFT",
            .middle_right => "MIDDLE_RIGHT",
            .top_center => "TOP_CENTER",
            .top_left => "TOP_LEFT",
            .top_right => "TOP_RIGHT",
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
