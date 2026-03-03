const std = @import("std");

pub const ComparisonOperator = enum {
    less_than,
    less_than_equals,
    greater_than,
    greater_than_equals,
    in_cidr_set,
    not_in_cidr_set,
    in_port_set,
    not_in_port_set,
    in_set,
    not_in_set,

    pub const json_field_names = .{
        .less_than = "less-than",
        .less_than_equals = "less-than-equals",
        .greater_than = "greater-than",
        .greater_than_equals = "greater-than-equals",
        .in_cidr_set = "in-cidr-set",
        .not_in_cidr_set = "not-in-cidr-set",
        .in_port_set = "in-port-set",
        .not_in_port_set = "not-in-port-set",
        .in_set = "in-set",
        .not_in_set = "not-in-set",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .less_than => "less-than",
            .less_than_equals => "less-than-equals",
            .greater_than => "greater-than",
            .greater_than_equals => "greater-than-equals",
            .in_cidr_set => "in-cidr-set",
            .not_in_cidr_set => "not-in-cidr-set",
            .in_port_set => "in-port-set",
            .not_in_port_set => "not-in-port-set",
            .in_set => "in-set",
            .not_in_set => "not-in-set",
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
