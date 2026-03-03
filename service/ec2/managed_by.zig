const std = @import("std");

pub const ManagedBy = enum {
    account,
    declarative_policy,

    pub const json_field_names = .{
        .account = "account",
        .declarative_policy = "declarative-policy",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account => "account",
            .declarative_policy => "declarative-policy",
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
