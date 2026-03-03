const std = @import("std");

pub const MessageTemplateQueryOperator = enum {
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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
