const std = @import("std");

pub const FeedbackValue = enum {
    not_specified,
    useful,
    not_useful,

    pub const json_field_names = .{
        .not_specified = "NOT_SPECIFIED",
        .useful = "USEFUL",
        .not_useful = "NOT_USEFUL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_specified => "NOT_SPECIFIED",
            .useful => "USEFUL",
            .not_useful => "NOT_USEFUL",
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
