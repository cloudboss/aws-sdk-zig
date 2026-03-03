const std = @import("std");

pub const InputType = enum {
    real_time,
    post_call,

    pub const json_field_names = .{
        .real_time = "REAL_TIME",
        .post_call = "POST_CALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .real_time => "REAL_TIME",
            .post_call => "POST_CALL",
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
