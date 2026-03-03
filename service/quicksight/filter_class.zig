const std = @import("std");

pub const FilterClass = enum {
    enforced_value_filter,
    conditional_value_filter,
    named_value_filter,

    pub const json_field_names = .{
        .enforced_value_filter = "ENFORCED_VALUE_FILTER",
        .conditional_value_filter = "CONDITIONAL_VALUE_FILTER",
        .named_value_filter = "NAMED_VALUE_FILTER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enforced_value_filter => "ENFORCED_VALUE_FILTER",
            .conditional_value_filter => "CONDITIONAL_VALUE_FILTER",
            .named_value_filter => "NAMED_VALUE_FILTER",
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
