const std = @import("std");

pub const FilterDimensionType = enum {
    inclusive,
    exclusive,
    contains,
    begins_with,
    ends_with,
    before,
    after,
    between,
    not_between,
    on,
    greater_than,
    less_than,
    greater_than_or_equal,
    less_than_or_equal,
    equal,

    pub const json_field_names = .{
        .inclusive = "INCLUSIVE",
        .exclusive = "EXCLUSIVE",
        .contains = "CONTAINS",
        .begins_with = "BEGINS_WITH",
        .ends_with = "ENDS_WITH",
        .before = "BEFORE",
        .after = "AFTER",
        .between = "BETWEEN",
        .not_between = "NOT_BETWEEN",
        .on = "ON",
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
        .greater_than_or_equal = "GREATER_THAN_OR_EQUAL",
        .less_than_or_equal = "LESS_THAN_OR_EQUAL",
        .equal = "EQUAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .inclusive => "INCLUSIVE",
            .exclusive => "EXCLUSIVE",
            .contains => "CONTAINS",
            .begins_with => "BEGINS_WITH",
            .ends_with => "ENDS_WITH",
            .before => "BEFORE",
            .after => "AFTER",
            .between => "BETWEEN",
            .not_between => "NOT_BETWEEN",
            .on => "ON",
            .greater_than => "GREATER_THAN",
            .less_than => "LESS_THAN",
            .greater_than_or_equal => "GREATER_THAN_OR_EQUAL",
            .less_than_or_equal => "LESS_THAN_OR_EQUAL",
            .equal => "EQUAL",
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
