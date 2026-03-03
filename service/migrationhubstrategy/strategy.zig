const std = @import("std");

pub const Strategy = enum {
    rehost,
    retirement,
    refactor,
    replatform,
    retain,
    relocate,
    repurchase,

    pub const json_field_names = .{
        .rehost = "Rehost",
        .retirement = "Retirement",
        .refactor = "Refactor",
        .replatform = "Replatform",
        .retain = "Retain",
        .relocate = "Relocate",
        .repurchase = "Repurchase",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rehost => "Rehost",
            .retirement => "Retirement",
            .refactor => "Refactor",
            .replatform => "Replatform",
            .retain => "Retain",
            .relocate => "Relocate",
            .repurchase => "Repurchase",
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
