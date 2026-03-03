const std = @import("std");

pub const LensStatus = enum {
    current,
    not_current,
    deprecated,
    deleted,
    unshared,

    pub const json_field_names = .{
        .current = "CURRENT",
        .not_current = "NOT_CURRENT",
        .deprecated = "DEPRECATED",
        .deleted = "DELETED",
        .unshared = "UNSHARED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .current => "CURRENT",
            .not_current => "NOT_CURRENT",
            .deprecated => "DEPRECATED",
            .deleted => "DELETED",
            .unshared => "UNSHARED",
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
