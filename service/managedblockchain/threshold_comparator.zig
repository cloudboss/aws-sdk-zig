const std = @import("std");

pub const ThresholdComparator = enum {
    greater_than,
    greater_than_or_equal_to,

    pub const json_field_names = .{
        .greater_than = "GREATER_THAN",
        .greater_than_or_equal_to = "GREATER_THAN_OR_EQUAL_TO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .greater_than => "GREATER_THAN",
            .greater_than_or_equal_to => "GREATER_THAN_OR_EQUAL_TO",
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
