const std = @import("std");

pub const FeedbackRating = enum {
    thumbs_up,
    thumbs_down,

    pub const json_field_names = .{
        .thumbs_up = "THUMBS_UP",
        .thumbs_down = "THUMBS_DOWN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .thumbs_up => "THUMBS_UP",
            .thumbs_down => "THUMBS_DOWN",
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
