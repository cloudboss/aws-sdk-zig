const std = @import("std");

pub const JSTarget = enum {
    es2015,
    es2020,

    pub const json_field_names = .{
        .es2015 = "es2015",
        .es2020 = "es2020",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .es2015 => "es2015",
            .es2020 => "es2020",
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
