const std = @import("std");

pub const ProjectionType = enum {
    all,
    keys_only,
    include,

    pub const json_field_names = .{
        .all = "ALL",
        .keys_only = "KEYS_ONLY",
        .include = "INCLUDE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all => "ALL",
            .keys_only => "KEYS_ONLY",
            .include => "INCLUDE",
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
