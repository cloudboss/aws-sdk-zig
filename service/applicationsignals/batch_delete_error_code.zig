const std = @import("std");

/// Error codes for batch delete item-level failures.
pub const BatchDeleteErrorCode = enum {
    /// Configuration already deleted or expired.
    resource_not_found,
    /// Insufficient permissions to delete the configuration.
    access_denied,
    /// Internal service error for this item.
    internal_service_error,

    pub const json_field_names = .{
        .resource_not_found = "ResourceNotFoundException",
        .access_denied = "AccessDeniedException",
        .internal_service_error = "InternalServiceException",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_not_found => "ResourceNotFoundException",
            .access_denied => "AccessDeniedException",
            .internal_service_error => "InternalServiceException",
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
