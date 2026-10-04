const std = @import("std");

pub const HandshakeConstraintViolationExceptionReason = enum {
    account_number_limit_exceeded,
    handshake_rate_limit_exceeded,
    already_in_an_organization,
    organization_already_has_all_features,
    organization_is_already_pending_all_features_migration,
    invite_disabled_during_enable_all_features,
    payment_instrument_required,
    organization_from_different_seller_of_record,
    organization_membership_change_rate_limit_exceeded,
    management_account_email_not_verified,
    responsibility_transfer_already_exists,
    source_and_target_cannot_match,
    unused_prepayment_balance,
    legacy_permissions_still_in_use,
    past_due_invoice,
    target_account_validation_failure,

    pub const json_field_names = .{
        .account_number_limit_exceeded = "ACCOUNT_NUMBER_LIMIT_EXCEEDED",
        .handshake_rate_limit_exceeded = "HANDSHAKE_RATE_LIMIT_EXCEEDED",
        .already_in_an_organization = "ALREADY_IN_AN_ORGANIZATION",
        .organization_already_has_all_features = "ORGANIZATION_ALREADY_HAS_ALL_FEATURES",
        .organization_is_already_pending_all_features_migration = "ORGANIZATION_IS_ALREADY_PENDING_ALL_FEATURES_MIGRATION",
        .invite_disabled_during_enable_all_features = "INVITE_DISABLED_DURING_ENABLE_ALL_FEATURES",
        .payment_instrument_required = "PAYMENT_INSTRUMENT_REQUIRED",
        .organization_from_different_seller_of_record = "ORGANIZATION_FROM_DIFFERENT_SELLER_OF_RECORD",
        .organization_membership_change_rate_limit_exceeded = "ORGANIZATION_MEMBERSHIP_CHANGE_RATE_LIMIT_EXCEEDED",
        .management_account_email_not_verified = "MANAGEMENT_ACCOUNT_EMAIL_NOT_VERIFIED",
        .responsibility_transfer_already_exists = "RESPONSIBILITY_TRANSFER_ALREADY_EXISTS",
        .source_and_target_cannot_match = "SOURCE_AND_TARGET_CANNOT_MATCH",
        .unused_prepayment_balance = "UNUSED_PREPAYMENT_BALANCE",
        .legacy_permissions_still_in_use = "LEGACY_PERMISSIONS_STILL_IN_USE",
        .past_due_invoice = "PAST_DUE_INVOICE",
        .target_account_validation_failure = "TARGET_ACCOUNT_VALIDATION_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_number_limit_exceeded => "ACCOUNT_NUMBER_LIMIT_EXCEEDED",
            .handshake_rate_limit_exceeded => "HANDSHAKE_RATE_LIMIT_EXCEEDED",
            .already_in_an_organization => "ALREADY_IN_AN_ORGANIZATION",
            .organization_already_has_all_features => "ORGANIZATION_ALREADY_HAS_ALL_FEATURES",
            .organization_is_already_pending_all_features_migration => "ORGANIZATION_IS_ALREADY_PENDING_ALL_FEATURES_MIGRATION",
            .invite_disabled_during_enable_all_features => "INVITE_DISABLED_DURING_ENABLE_ALL_FEATURES",
            .payment_instrument_required => "PAYMENT_INSTRUMENT_REQUIRED",
            .organization_from_different_seller_of_record => "ORGANIZATION_FROM_DIFFERENT_SELLER_OF_RECORD",
            .organization_membership_change_rate_limit_exceeded => "ORGANIZATION_MEMBERSHIP_CHANGE_RATE_LIMIT_EXCEEDED",
            .management_account_email_not_verified => "MANAGEMENT_ACCOUNT_EMAIL_NOT_VERIFIED",
            .responsibility_transfer_already_exists => "RESPONSIBILITY_TRANSFER_ALREADY_EXISTS",
            .source_and_target_cannot_match => "SOURCE_AND_TARGET_CANNOT_MATCH",
            .unused_prepayment_balance => "UNUSED_PREPAYMENT_BALANCE",
            .legacy_permissions_still_in_use => "LEGACY_PERMISSIONS_STILL_IN_USE",
            .past_due_invoice => "PAST_DUE_INVOICE",
            .target_account_validation_failure => "TARGET_ACCOUNT_VALIDATION_FAILURE",
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
