const std = @import("std");

pub const FilterClass = enum {
    enforced_value_filter,
    conditional_value_filter,
    named_value_filter,
    dashboard_default_filter,

    pub const json_field_names = .{
        .enforced_value_filter = "ENFORCED_VALUE_FILTER",
        .conditional_value_filter = "CONDITIONAL_VALUE_FILTER",
        .named_value_filter = "NAMED_VALUE_FILTER",
        .dashboard_default_filter = "DASHBOARD_DEFAULT_FILTER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .enforced_value_filter => "ENFORCED_VALUE_FILTER",
            .conditional_value_filter => "CONDITIONAL_VALUE_FILTER",
            .named_value_filter => "NAMED_VALUE_FILTER",
            .dashboard_default_filter => "DASHBOARD_DEFAULT_FILTER",
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
