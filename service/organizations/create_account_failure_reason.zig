const std = @import("std");

pub const CreateAccountFailureReason = enum {
    account_limit_exceeded,
    email_already_exists,
    invalid_address,
    invalid_email,
    concurrent_account_modification,
    internal_failure,
    govcloud_account_already_exists,
    missing_business_validation,
    failed_business_validation,
    pending_business_validatio_nv,
    invalid_identity_for_business_validation,
    unknown_business_validation,
    missing_payment_instrument,
    invalid_payment_instrument,
    update_existing_resource_policy_with_tags_not_supported,

    pub const json_field_names = .{
        .account_limit_exceeded = "ACCOUNT_LIMIT_EXCEEDED",
        .email_already_exists = "EMAIL_ALREADY_EXISTS",
        .invalid_address = "INVALID_ADDRESS",
        .invalid_email = "INVALID_EMAIL",
        .concurrent_account_modification = "CONCURRENT_ACCOUNT_MODIFICATION",
        .internal_failure = "INTERNAL_FAILURE",
        .govcloud_account_already_exists = "GOVCLOUD_ACCOUNT_ALREADY_EXISTS",
        .missing_business_validation = "MISSING_BUSINESS_VALIDATION",
        .failed_business_validation = "FAILED_BUSINESS_VALIDATION",
        .pending_business_validatio_nv = "PENDING_BUSINESS_VALIDATION",
        .invalid_identity_for_business_validation = "INVALID_IDENTITY_FOR_BUSINESS_VALIDATION",
        .unknown_business_validation = "UNKNOWN_BUSINESS_VALIDATION",
        .missing_payment_instrument = "MISSING_PAYMENT_INSTRUMENT",
        .invalid_payment_instrument = "INVALID_PAYMENT_INSTRUMENT",
        .update_existing_resource_policy_with_tags_not_supported = "UPDATE_EXISTING_RESOURCE_POLICY_WITH_TAGS_NOT_SUPPORTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_limit_exceeded => "ACCOUNT_LIMIT_EXCEEDED",
            .email_already_exists => "EMAIL_ALREADY_EXISTS",
            .invalid_address => "INVALID_ADDRESS",
            .invalid_email => "INVALID_EMAIL",
            .concurrent_account_modification => "CONCURRENT_ACCOUNT_MODIFICATION",
            .internal_failure => "INTERNAL_FAILURE",
            .govcloud_account_already_exists => "GOVCLOUD_ACCOUNT_ALREADY_EXISTS",
            .missing_business_validation => "MISSING_BUSINESS_VALIDATION",
            .failed_business_validation => "FAILED_BUSINESS_VALIDATION",
            .pending_business_validatio_nv => "PENDING_BUSINESS_VALIDATION",
            .invalid_identity_for_business_validation => "INVALID_IDENTITY_FOR_BUSINESS_VALIDATION",
            .unknown_business_validation => "UNKNOWN_BUSINESS_VALIDATION",
            .missing_payment_instrument => "MISSING_PAYMENT_INSTRUMENT",
            .invalid_payment_instrument => "INVALID_PAYMENT_INSTRUMENT",
            .update_existing_resource_policy_with_tags_not_supported => "UPDATE_EXISTING_RESOURCE_POLICY_WITH_TAGS_NOT_SUPPORTED",
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
