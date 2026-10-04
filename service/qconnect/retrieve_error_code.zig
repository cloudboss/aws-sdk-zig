const std = @import("std");

/// The error code that categorizes a per-association retrieval failure.
///
/// * `ACCESS_DENIED` – you do not have permission to retrieve from the
///   knowledge base for the assistant association.
/// * `RESOURCE_NOT_FOUND` – the assistant association or its knowledge base
///   could not be found.
/// * `VALIDATION_ERROR` – the retrieval request or the knowledge base
///   configuration for the assistant association was not valid.
/// * `THROTTLED` – the retrieval request for the assistant association was
///   throttled.
/// * `DEPENDENCY_FAILED` – a dependency required to query the assistant
///   association failed.
/// * `INTERNAL_SERVER_ERROR` – an internal error occurred while querying the
///   assistant association.
pub const RetrieveErrorCode = enum {
    access_denied,
    resource_not_found,
    validation_error,
    throttled,
    dependency_failed,
    internal_server_error,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .validation_error = "VALIDATION_ERROR",
        .throttled = "THROTTLED",
        .dependency_failed = "DEPENDENCY_FAILED",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_denied => "ACCESS_DENIED",
            .resource_not_found => "RESOURCE_NOT_FOUND",
            .validation_error => "VALIDATION_ERROR",
            .throttled => "THROTTLED",
            .dependency_failed => "DEPENDENCY_FAILED",
            .internal_server_error => "INTERNAL_SERVER_ERROR",
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
