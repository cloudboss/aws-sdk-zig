const std = @import("std");

pub const PropertyType = enum {
    user_input,
    secret,
    read_only,
    unused,
    secret_or_user_input,

    pub const json_field_names = .{
        .user_input = "USER_INPUT",
        .secret = "SECRET",
        .read_only = "READ_ONLY",
        .unused = "UNUSED",
        .secret_or_user_input = "SECRET_OR_USER_INPUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user_input => "USER_INPUT",
            .secret => "SECRET",
            .read_only => "READ_ONLY",
            .unused => "UNUSED",
            .secret_or_user_input => "SECRET_OR_USER_INPUT",
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
