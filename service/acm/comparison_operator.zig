const std = @import("std");

/// The comparison operator to use for string filters. Valid values are
/// `CONTAINS` and `EQUALS`.
pub const ComparisonOperator = enum {
    contains,
    equals,

    pub const json_field_names = .{
        .contains = "CONTAINS",
        .equals = "EQUALS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .contains => "CONTAINS",
            .equals => "EQUALS",
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
