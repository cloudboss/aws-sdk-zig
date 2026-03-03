const std = @import("std");

pub const UserContextPolicy = enum {
    attribute_filter,
    user_token,

    pub const json_field_names = .{
        .attribute_filter = "ATTRIBUTE_FILTER",
        .user_token = "USER_TOKEN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .attribute_filter => "ATTRIBUTE_FILTER",
            .user_token => "USER_TOKEN",
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
