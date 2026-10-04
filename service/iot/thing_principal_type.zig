const std = @import("std");

pub const ThingPrincipalType = enum {
    exclusive_thing,
    non_exclusive_thing,

    pub const json_field_names = .{
        .exclusive_thing = "EXCLUSIVE_THING",
        .non_exclusive_thing = "NON_EXCLUSIVE_THING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .exclusive_thing => "EXCLUSIVE_THING",
            .non_exclusive_thing => "NON_EXCLUSIVE_THING",
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
