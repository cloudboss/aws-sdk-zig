const std = @import("std");

pub const FieldFilterOperator = enum {
    less_than,
    greater_than,
    between,
    equal_to,
    not_equal_to,
    greater_than_or_equal_to,
    less_than_or_equal_to,
    contains,
    order_by,

    pub const json_field_names = .{
        .less_than = "LESS_THAN",
        .greater_than = "GREATER_THAN",
        .between = "BETWEEN",
        .equal_to = "EQUAL_TO",
        .not_equal_to = "NOT_EQUAL_TO",
        .greater_than_or_equal_to = "GREATER_THAN_OR_EQUAL_TO",
        .less_than_or_equal_to = "LESS_THAN_OR_EQUAL_TO",
        .contains = "CONTAINS",
        .order_by = "ORDER_BY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .less_than => "LESS_THAN",
            .greater_than => "GREATER_THAN",
            .between => "BETWEEN",
            .equal_to => "EQUAL_TO",
            .not_equal_to => "NOT_EQUAL_TO",
            .greater_than_or_equal_to => "GREATER_THAN_OR_EQUAL_TO",
            .less_than_or_equal_to => "LESS_THAN_OR_EQUAL_TO",
            .contains => "CONTAINS",
            .order_by => "ORDER_BY",
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
