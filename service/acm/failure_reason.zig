const std = @import("std");

pub const FailureReason = enum {
    no_available_contacts,
    additional_verification_required,
    domain_not_allowed,
    invalid_public_domain,
    domain_validation_denied,
    caa_error,
    pca_limit_exceeded,
    pca_invalid_arn,
    pca_invalid_state,
    pca_request_failed,
    pca_name_constraints_validation,
    pca_resource_not_found,
    pca_invalid_args,
    pca_invalid_duration,
    pca_access_denied,
    slr_not_found,
    other,

    pub const json_field_names = .{
        .no_available_contacts = "NO_AVAILABLE_CONTACTS",
        .additional_verification_required = "ADDITIONAL_VERIFICATION_REQUIRED",
        .domain_not_allowed = "DOMAIN_NOT_ALLOWED",
        .invalid_public_domain = "INVALID_PUBLIC_DOMAIN",
        .domain_validation_denied = "DOMAIN_VALIDATION_DENIED",
        .caa_error = "CAA_ERROR",
        .pca_limit_exceeded = "PCA_LIMIT_EXCEEDED",
        .pca_invalid_arn = "PCA_INVALID_ARN",
        .pca_invalid_state = "PCA_INVALID_STATE",
        .pca_request_failed = "PCA_REQUEST_FAILED",
        .pca_name_constraints_validation = "PCA_NAME_CONSTRAINTS_VALIDATION",
        .pca_resource_not_found = "PCA_RESOURCE_NOT_FOUND",
        .pca_invalid_args = "PCA_INVALID_ARGS",
        .pca_invalid_duration = "PCA_INVALID_DURATION",
        .pca_access_denied = "PCA_ACCESS_DENIED",
        .slr_not_found = "SLR_NOT_FOUND",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .no_available_contacts => "NO_AVAILABLE_CONTACTS",
            .additional_verification_required => "ADDITIONAL_VERIFICATION_REQUIRED",
            .domain_not_allowed => "DOMAIN_NOT_ALLOWED",
            .invalid_public_domain => "INVALID_PUBLIC_DOMAIN",
            .domain_validation_denied => "DOMAIN_VALIDATION_DENIED",
            .caa_error => "CAA_ERROR",
            .pca_limit_exceeded => "PCA_LIMIT_EXCEEDED",
            .pca_invalid_arn => "PCA_INVALID_ARN",
            .pca_invalid_state => "PCA_INVALID_STATE",
            .pca_request_failed => "PCA_REQUEST_FAILED",
            .pca_name_constraints_validation => "PCA_NAME_CONSTRAINTS_VALIDATION",
            .pca_resource_not_found => "PCA_RESOURCE_NOT_FOUND",
            .pca_invalid_args => "PCA_INVALID_ARGS",
            .pca_invalid_duration => "PCA_INVALID_DURATION",
            .pca_access_denied => "PCA_ACCESS_DENIED",
            .slr_not_found => "SLR_NOT_FOUND",
            .other => "OTHER",
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
