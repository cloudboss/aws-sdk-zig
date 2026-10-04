const std = @import("std");

pub const TopicIRFilterFunction = enum {
    contains,
    exact,
    starts_with,
    ends_with,
    contains_string,
    previous,
    this,
    last,
    next,
    now,

    pub const json_field_names = .{
        .contains = "CONTAINS",
        .exact = "EXACT",
        .starts_with = "STARTS_WITH",
        .ends_with = "ENDS_WITH",
        .contains_string = "CONTAINS_STRING",
        .previous = "PREVIOUS",
        .this = "THIS",
        .last = "LAST",
        .next = "NEXT",
        .now = "NOW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .contains => "CONTAINS",
            .exact => "EXACT",
            .starts_with => "STARTS_WITH",
            .ends_with => "ENDS_WITH",
            .contains_string => "CONTAINS_STRING",
            .previous => "PREVIOUS",
            .this => "THIS",
            .last => "LAST",
            .next => "NEXT",
            .now => "NOW",
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
