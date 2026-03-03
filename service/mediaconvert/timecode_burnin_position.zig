const std = @import("std");

/// Use Position under Timecode burn-in to specify the location the burned-in
/// timecode on output video.
pub const TimecodeBurninPosition = enum {
    top_center,
    top_left,
    top_right,
    middle_left,
    middle_center,
    middle_right,
    bottom_left,
    bottom_center,
    bottom_right,

    pub const json_field_names = .{
        .top_center = "TOP_CENTER",
        .top_left = "TOP_LEFT",
        .top_right = "TOP_RIGHT",
        .middle_left = "MIDDLE_LEFT",
        .middle_center = "MIDDLE_CENTER",
        .middle_right = "MIDDLE_RIGHT",
        .bottom_left = "BOTTOM_LEFT",
        .bottom_center = "BOTTOM_CENTER",
        .bottom_right = "BOTTOM_RIGHT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .top_center => "TOP_CENTER",
            .top_left => "TOP_LEFT",
            .top_right => "TOP_RIGHT",
            .middle_left => "MIDDLE_LEFT",
            .middle_center => "MIDDLE_CENTER",
            .middle_right => "MIDDLE_RIGHT",
            .bottom_left => "BOTTOM_LEFT",
            .bottom_center => "BOTTOM_CENTER",
            .bottom_right => "BOTTOM_RIGHT",
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
