const std = @import("std");

pub const MarketoConnectorOperator = enum {
    projection,
    less_than,
    greater_than,
    between,
    addition,
    multiplication,
    division,
    subtraction,
    mask_all,
    mask_first_n,
    mask_last_n,
    validate_non_null,
    validate_non_zero,
    validate_non_negative,
    validate_numeric,
    no_op,

    pub const json_field_names = .{
        .projection = "PROJECTION",
        .less_than = "LESS_THAN",
        .greater_than = "GREATER_THAN",
        .between = "BETWEEN",
        .addition = "ADDITION",
        .multiplication = "MULTIPLICATION",
        .division = "DIVISION",
        .subtraction = "SUBTRACTION",
        .mask_all = "MASK_ALL",
        .mask_first_n = "MASK_FIRST_N",
        .mask_last_n = "MASK_LAST_N",
        .validate_non_null = "VALIDATE_NON_NULL",
        .validate_non_zero = "VALIDATE_NON_ZERO",
        .validate_non_negative = "VALIDATE_NON_NEGATIVE",
        .validate_numeric = "VALIDATE_NUMERIC",
        .no_op = "NO_OP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .projection => "PROJECTION",
            .less_than => "LESS_THAN",
            .greater_than => "GREATER_THAN",
            .between => "BETWEEN",
            .addition => "ADDITION",
            .multiplication => "MULTIPLICATION",
            .division => "DIVISION",
            .subtraction => "SUBTRACTION",
            .mask_all => "MASK_ALL",
            .mask_first_n => "MASK_FIRST_N",
            .mask_last_n => "MASK_LAST_N",
            .validate_non_null => "VALIDATE_NON_NULL",
            .validate_non_zero => "VALIDATE_NON_ZERO",
            .validate_non_negative => "VALIDATE_NON_NEGATIVE",
            .validate_numeric => "VALIDATE_NUMERIC",
            .no_op => "NO_OP",
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
