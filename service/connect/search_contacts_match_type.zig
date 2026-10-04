const std = @import("std");

pub const SearchContactsMatchType = enum {
    match_all,
    match_any,
    match_exact,
    match_none,

    pub const json_field_names = .{
        .match_all = "MATCH_ALL",
        .match_any = "MATCH_ANY",
        .match_exact = "MATCH_EXACT",
        .match_none = "MATCH_NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .match_all => "MATCH_ALL",
            .match_any => "MATCH_ANY",
            .match_exact => "MATCH_EXACT",
            .match_none => "MATCH_NONE",
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
