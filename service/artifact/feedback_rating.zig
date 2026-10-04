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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
