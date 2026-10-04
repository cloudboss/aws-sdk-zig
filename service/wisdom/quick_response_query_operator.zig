const std = @import("std");

pub const QuickResponseQueryOperator = enum {
    contains,
    contains_and_prefix,

    pub const json_field_names = .{
        .contains = "CONTAINS",
        .contains_and_prefix = "CONTAINS_AND_PREFIX",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .contains => "CONTAINS",
            .contains_and_prefix => "CONTAINS_AND_PREFIX",
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
