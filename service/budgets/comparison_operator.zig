const std = @import("std");

/// The comparison operator of a notification. Currently, the service supports
/// the
/// following operators:
///
/// `GREATER_THAN`, `LESS_THAN`, `EQUAL_TO`
pub const ComparisonOperator = enum {
    greater_than,
    less_than,
    equal_to,

    pub const json_field_names = .{
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
        .equal_to = "EQUAL_TO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .greater_than => "GREATER_THAN",
            .less_than => "LESS_THAN",
            .equal_to => "EQUAL_TO",
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
