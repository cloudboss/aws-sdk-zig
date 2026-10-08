const std = @import("std");

/// Whether a test run targets resources in a single AWS account or across
/// multiple accounts.
pub const AccountTargeting = enum {
    /// Test run targets resources in the same account only.
    single_account,
    /// Test run targets resources across multiple accounts.
    multi_account,

    pub const json_field_names = .{
        .single_account = "SINGLE_ACCOUNT",
        .multi_account = "MULTI_ACCOUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_account => "SINGLE_ACCOUNT",
            .multi_account => "MULTI_ACCOUNT",
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
