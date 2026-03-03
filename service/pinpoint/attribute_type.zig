const std = @import("std");

pub const AttributeType = enum {
    inclusive,
    exclusive,
    contains,
    before,
    after,
    on,
    between,

    pub const json_field_names = .{
        .inclusive = "INCLUSIVE",
        .exclusive = "EXCLUSIVE",
        .contains = "CONTAINS",
        .before = "BEFORE",
        .after = "AFTER",
        .on = "ON",
        .between = "BETWEEN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .inclusive => "INCLUSIVE",
            .exclusive => "EXCLUSIVE",
            .contains => "CONTAINS",
            .before => "BEFORE",
            .after => "AFTER",
            .on => "ON",
            .between => "BETWEEN",
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
