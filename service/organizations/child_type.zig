const std = @import("std");

pub const ChildType = enum {
    account,
    organizational_unit,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .organizational_unit = "ORGANIZATIONAL_UNIT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account => "ACCOUNT",
            .organizational_unit => "ORGANIZATIONAL_UNIT",
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
