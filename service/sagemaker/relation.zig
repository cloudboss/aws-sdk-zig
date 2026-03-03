const std = @import("std");

pub const Relation = enum {
    equal_to,
    greater_than_or_equal_to,

    pub const json_field_names = .{
        .equal_to = "EqualTo",
        .greater_than_or_equal_to = "GreaterThanOrEqualTo",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equal_to => "EqualTo",
            .greater_than_or_equal_to => "GreaterThanOrEqualTo",
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
