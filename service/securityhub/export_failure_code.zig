const std = @import("std");

/// Classifies why a terminal-state export job failed. Present only when
/// `Status` is `FAILED`. Valid values are as follows:
///
/// * `ACCESS_DENIED` – Security Hub couldn't read a required resource or write
///   to the destination. Verify the bucket policy and key policy.
///
/// * `RESOURCE_NOT_FOUND` – A referenced destination bucket or Amazon Web
///   Services KMS key no longer exists.
///
/// * `INTERNAL_ERROR` – An unclassified service-side error occurred. Retry the
///   export, and if the failure persists, contact Amazon Web Services Support.
pub const ExportFailureCode = enum {
    access_denied,
    resource_not_found,
    internal_error,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .resource_not_found = "RESOURCE_NOT_FOUND",
        .internal_error = "INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_denied => "ACCESS_DENIED",
            .resource_not_found => "RESOURCE_NOT_FOUND",
            .internal_error => "INTERNAL_ERROR",
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
