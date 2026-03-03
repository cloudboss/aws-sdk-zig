const std = @import("std");

pub const AccountAccessType = enum {
    /// Indicates that the customer is using Grafana to monitor resources in their
    /// current account.
    current_account,
    /// Indicates that the customer is using Grafana to monitor resources in
    /// organizational units.
    organization,

    pub const json_field_names = .{
        .current_account = "CURRENT_ACCOUNT",
        .organization = "ORGANIZATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .current_account => "CURRENT_ACCOUNT",
            .organization => "ORGANIZATION",
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
