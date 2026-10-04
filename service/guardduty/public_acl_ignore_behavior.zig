const std = @import("std");

pub const PublicAclIgnoreBehavior = enum {
    ignored,
    not_ignored,

    pub const json_field_names = .{
        .ignored = "IGNORED",
        .not_ignored = "NOT_IGNORED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ignored => "IGNORED",
            .not_ignored => "NOT_IGNORED",
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
