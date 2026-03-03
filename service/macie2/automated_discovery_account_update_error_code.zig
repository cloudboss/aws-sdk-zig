const std = @import("std");

/// The error code that indicates why a request failed to change the status of
/// automated sensitive data discovery for an Amazon Macie account. Possible
/// values are:
pub const AutomatedDiscoveryAccountUpdateErrorCode = enum {
    account_paused,
    account_not_found,

    pub const json_field_names = .{
        .account_paused = "ACCOUNT_PAUSED",
        .account_not_found = "ACCOUNT_NOT_FOUND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_paused => "ACCOUNT_PAUSED",
            .account_not_found => "ACCOUNT_NOT_FOUND",
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
