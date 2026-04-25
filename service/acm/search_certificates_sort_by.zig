const std = @import("std");

/// The field to sort search results by.
pub const SearchCertificatesSortBy = enum {
    created_at,
    not_after,
    status,
    renewal_status,
    exported,
    in_use,
    not_before,
    key_algorithm,
    @"type",
    certificate_arn,
    common_name,
    revoked_at,
    renewal_eligibility,
    issued_at,
    managed_by,
    export_option,
    validation_method,
    imported_at,

    pub const json_field_names = .{
        .created_at = "CREATED_AT",
        .not_after = "NOT_AFTER",
        .status = "STATUS",
        .renewal_status = "RENEWAL_STATUS",
        .exported = "EXPORTED",
        .in_use = "IN_USE",
        .not_before = "NOT_BEFORE",
        .key_algorithm = "KEY_ALGORITHM",
        .@"type" = "TYPE",
        .certificate_arn = "CERTIFICATE_ARN",
        .common_name = "COMMON_NAME",
        .revoked_at = "REVOKED_AT",
        .renewal_eligibility = "RENEWAL_ELIGIBILITY",
        .issued_at = "ISSUED_AT",
        .managed_by = "MANAGED_BY",
        .export_option = "EXPORT_OPTION",
        .validation_method = "VALIDATION_METHOD",
        .imported_at = "IMPORTED_AT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created_at => "CREATED_AT",
            .not_after => "NOT_AFTER",
            .status => "STATUS",
            .renewal_status => "RENEWAL_STATUS",
            .exported => "EXPORTED",
            .in_use => "IN_USE",
            .not_before => "NOT_BEFORE",
            .key_algorithm => "KEY_ALGORITHM",
            .@"type" => "TYPE",
            .certificate_arn => "CERTIFICATE_ARN",
            .common_name => "COMMON_NAME",
            .revoked_at => "REVOKED_AT",
            .renewal_eligibility => "RENEWAL_ELIGIBILITY",
            .issued_at => "ISSUED_AT",
            .managed_by => "MANAGED_BY",
            .export_option => "EXPORT_OPTION",
            .validation_method => "VALIDATION_METHOD",
            .imported_at => "IMPORTED_AT",
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
