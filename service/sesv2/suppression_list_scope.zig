const std = @import("std");

/// The suppression scope that determines which suppression list Amazon SES
/// uses. Can be one of the
/// following:
///
/// * `TENANT` – Use the tenant's own suppression list.
///
/// * `ACCOUNT` – Use the account-level suppression list.
pub const SuppressionListScope = enum {
    account,
    tenant,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .tenant = "TENANT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account => "ACCOUNT",
            .tenant => "TENANT",
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
