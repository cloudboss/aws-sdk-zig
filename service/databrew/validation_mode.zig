const std = @import("std");

pub const ValidationMode = enum {
    check_all,

    pub const json_field_names = .{
        .check_all = "CHECK_ALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .check_all => "CHECK_ALL",
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
