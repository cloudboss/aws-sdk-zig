const std = @import("std");

/// The error code associated with the error.
pub const SharedResourceErrorCode = enum {
    quota_exceeded,
    share_not_found,
    invite_failed,
    setup_incomplete,
    internal_error,
    az_mismatch,
    resource_configuration_not_found,

    pub const json_field_names = .{
        .quota_exceeded = "QUOTA_EXCEEDED",
        .share_not_found = "SHARE_NOT_FOUND",
        .invite_failed = "INVITE_FAILED",
        .setup_incomplete = "SETUP_INCOMPLETE",
        .internal_error = "INTERNAL_ERROR",
        .az_mismatch = "AZ_MISMATCH",
        .resource_configuration_not_found = "RESOURCE_CONFIGURATION_NOT_FOUND",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .quota_exceeded => "QUOTA_EXCEEDED",
            .share_not_found => "SHARE_NOT_FOUND",
            .invite_failed => "INVITE_FAILED",
            .setup_incomplete => "SETUP_INCOMPLETE",
            .internal_error => "INTERNAL_ERROR",
            .az_mismatch => "AZ_MISMATCH",
            .resource_configuration_not_found => "RESOURCE_CONFIGURATION_NOT_FOUND",
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
