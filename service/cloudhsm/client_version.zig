const std = @import("std");

pub const ClientVersion = enum {
    five_one,
    five_three,

    pub const json_field_names = .{
        .five_one = "5.1",
        .five_three = "5.3",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .five_one => "5.1",
            .five_three => "5.3",
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
