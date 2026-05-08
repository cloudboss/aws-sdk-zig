const std = @import("std");

pub const MemoryRecordOperatorType = enum {
    equals_to,
    exists,
    not_exists,
    before,
    after,
    contains,
    greater_than,
    greater_than_or_equals,
    less_than,
    less_than_or_equals,

    pub const json_field_names = .{
        .equals_to = "EQUALS_TO",
        .exists = "EXISTS",
        .not_exists = "NOT_EXISTS",
        .before = "BEFORE",
        .after = "AFTER",
        .contains = "CONTAINS",
        .greater_than = "GREATER_THAN",
        .greater_than_or_equals = "GREATER_THAN_OR_EQUALS",
        .less_than = "LESS_THAN",
        .less_than_or_equals = "LESS_THAN_OR_EQUALS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals_to => "EQUALS_TO",
            .exists => "EXISTS",
            .not_exists => "NOT_EXISTS",
            .before => "BEFORE",
            .after => "AFTER",
            .contains => "CONTAINS",
            .greater_than => "GREATER_THAN",
            .greater_than_or_equals => "GREATER_THAN_OR_EQUALS",
            .less_than => "LESS_THAN",
            .less_than_or_equals => "LESS_THAN_OR_EQUALS",
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
