const std = @import("std");

/// The type of pattern matching to apply.
pub const PreferenceType = enum {
    starts_with,
    ends_with,
    contains,
    exact_match,

    pub const json_field_names = .{
        .starts_with = "StartsWith",
        .ends_with = "EndsWith",
        .contains = "Contains",
        .exact_match = "ExactMatch",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .starts_with => "StartsWith",
            .ends_with => "EndsWith",
            .contains => "Contains",
            .exact_match => "ExactMatch",
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
