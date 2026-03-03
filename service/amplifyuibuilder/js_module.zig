const std = @import("std");

pub const JSModule = enum {
    es2020,
    esnext,

    pub const json_field_names = .{
        .es2020 = "es2020",
        .esnext = "esnext",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .es2020 => "es2020",
            .esnext => "esnext",
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
