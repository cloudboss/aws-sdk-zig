const std = @import("std");

pub const ControlRelationType = enum {
    complementary,
    alternative,
    mutually_exclusive,

    pub const json_field_names = .{
        .complementary = "COMPLEMENTARY",
        .alternative = "ALTERNATIVE",
        .mutually_exclusive = "MUTUALLY_EXCLUSIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .complementary => "COMPLEMENTARY",
            .alternative => "ALTERNATIVE",
            .mutually_exclusive => "MUTUALLY_EXCLUSIVE",
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
