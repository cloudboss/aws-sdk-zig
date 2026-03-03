const std = @import("std");

pub const AssociationResultStatusCode = enum {
    internal_error,
    access_denied,
    scan_configuration_not_found,
    invalid_input,
    resource_not_found,
    quota_exceeded,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .access_denied = "ACCESS_DENIED",
        .scan_configuration_not_found = "SCAN_CONFIGURATION_NOT_FOUND",
        .invalid_input = "INVALID_INPUT",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .quota_exceeded = "QUOTA_EXCEEDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_error => "INTERNAL_ERROR",
            .access_denied => "ACCESS_DENIED",
            .scan_configuration_not_found => "SCAN_CONFIGURATION_NOT_FOUND",
            .invalid_input => "INVALID_INPUT",
            .resource_not_found => "RESOURCE_NOT_FOUND",
            .quota_exceeded => "QUOTA_EXCEEDED",
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
