const std = @import("std");

pub const BatchItemErrorCode = enum {
    /// Access to the resource was denied.
    access_denied_error,
    /// The target resource already exists.
    conflict_error,
    /// Internal server error.
    internal_server_error,
    /// The target resource does not exist.
    resource_not_found_error,
    /// Too many requests.
    throttling_error,
    /// Input fails to satisfy the constraints specified by the service.
    validation_error,

    pub const json_field_names = .{
        .access_denied_error = "AccessDeniedError",
        .conflict_error = "ConflictError",
        .internal_server_error = "InternalServerError",
        .resource_not_found_error = "ResourceNotFoundError",
        .throttling_error = "ThrottlingError",
        .validation_error = "ValidationError",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_denied_error => "AccessDeniedError",
            .conflict_error => "ConflictError",
            .internal_server_error => "InternalServerError",
            .resource_not_found_error => "ResourceNotFoundError",
            .throttling_error => "ThrottlingError",
            .validation_error => "ValidationError",
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
