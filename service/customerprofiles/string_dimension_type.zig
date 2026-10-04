const std = @import("std");

pub const StringDimensionType = enum {
    inclusive,
    exclusive,
    contains,
    begins_with,
    ends_with,

    pub const json_field_names = .{
        .inclusive = "INCLUSIVE",
        .exclusive = "EXCLUSIVE",
        .contains = "CONTAINS",
        .begins_with = "BEGINS_WITH",
        .ends_with = "ENDS_WITH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .inclusive => "INCLUSIVE",
            .exclusive => "EXCLUSIVE",
            .contains => "CONTAINS",
            .begins_with => "BEGINS_WITH",
            .ends_with => "ENDS_WITH",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
