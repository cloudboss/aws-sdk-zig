const std = @import("std");

pub const NumberAttributeBoostingType = enum {
    prioritize_larger_values,
    prioritize_smaller_values,

    pub const json_field_names = .{
        .prioritize_larger_values = "PRIORITIZE_LARGER_VALUES",
        .prioritize_smaller_values = "PRIORITIZE_SMALLER_VALUES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .prioritize_larger_values => "PRIORITIZE_LARGER_VALUES",
            .prioritize_smaller_values => "PRIORITIZE_SMALLER_VALUES",
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
