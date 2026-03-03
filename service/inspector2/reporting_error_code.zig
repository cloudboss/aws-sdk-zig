const std = @import("std");

pub const ReportingErrorCode = enum {
    internal_error,
    invalid_permissions,
    no_findings_found,
    bucket_not_found,
    incompatible_bucket_region,
    malformed_kms_key,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .invalid_permissions = "INVALID_PERMISSIONS",
        .no_findings_found = "NO_FINDINGS_FOUND",
        .bucket_not_found = "BUCKET_NOT_FOUND",
        .incompatible_bucket_region = "INCOMPATIBLE_BUCKET_REGION",
        .malformed_kms_key = "MALFORMED_KMS_KEY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_error => "INTERNAL_ERROR",
            .invalid_permissions => "INVALID_PERMISSIONS",
            .no_findings_found => "NO_FINDINGS_FOUND",
            .bucket_not_found => "BUCKET_NOT_FOUND",
            .incompatible_bucket_region => "INCOMPATIBLE_BUCKET_REGION",
            .malformed_kms_key => "MALFORMED_KMS_KEY",
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
