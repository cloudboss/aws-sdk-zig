const std = @import("std");

pub const SearchTermMatchingType = enum {
    fuzzy_match,
    contains,

    pub const json_field_names = .{
        .fuzzy_match = "FUZZY_MATCH",
        .contains = "CONTAINS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fuzzy_match => "FUZZY_MATCH",
            .contains => "CONTAINS",
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
