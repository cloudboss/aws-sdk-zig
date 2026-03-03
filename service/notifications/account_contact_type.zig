const std = @import("std");

pub const AccountContactType = enum {
    /// Primary Contact managed by AWS Account Management Service.
    account_primary,
    /// Alternate Billing Contact managed by AWS Account Management Service.
    account_alternate_billing,
    /// Alternate Operations Contact managed by AWS Account Management Service.
    account_alternate_operations,
    /// Alternate Security Contact managed by AWS Account Management Service.
    account_alternate_security,

    pub const json_field_names = .{
        .account_primary = "ACCOUNT_PRIMARY",
        .account_alternate_billing = "ACCOUNT_ALTERNATE_BILLING",
        .account_alternate_operations = "ACCOUNT_ALTERNATE_OPERATIONS",
        .account_alternate_security = "ACCOUNT_ALTERNATE_SECURITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_primary => "ACCOUNT_PRIMARY",
            .account_alternate_billing => "ACCOUNT_ALTERNATE_BILLING",
            .account_alternate_operations => "ACCOUNT_ALTERNATE_OPERATIONS",
            .account_alternate_security => "ACCOUNT_ALTERNATE_SECURITY",
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
