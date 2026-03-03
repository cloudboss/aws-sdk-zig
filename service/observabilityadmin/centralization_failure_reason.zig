const std = @import("std");

pub const CentralizationFailureReason = enum {
    trusted_access_not_enabled,
    destination_account_not_in_organization,
    internal_server_error,

    pub const json_field_names = .{
        .trusted_access_not_enabled = "TRUSTED_ACCESS_NOT_ENABLED",
        .destination_account_not_in_organization = "DESTINATION_ACCOUNT_NOT_IN_ORGANIZATION",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .trusted_access_not_enabled => "TRUSTED_ACCESS_NOT_ENABLED",
            .destination_account_not_in_organization => "DESTINATION_ACCOUNT_NOT_IN_ORGANIZATION",
            .internal_server_error => "INTERNAL_SERVER_ERROR",
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
