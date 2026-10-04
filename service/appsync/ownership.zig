const std = @import("std");

pub const Ownership = enum {
    current_account,
    other_accounts,

    pub const json_field_names = .{
        .current_account = "CURRENT_ACCOUNT",
        .other_accounts = "OTHER_ACCOUNTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .current_account => "CURRENT_ACCOUNT",
            .other_accounts => "OTHER_ACCOUNTS",
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
