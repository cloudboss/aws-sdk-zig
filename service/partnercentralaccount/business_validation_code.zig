const std = @import("std");

pub const BusinessValidationCode = enum {
    incompatible_connection_invitation_request,
    incompatible_legal_name,
    incompatible_know_your_business_status,
    incompatible_identity_verification_status,
    invalid_account_linking_status,
    invalid_account_state,
    incompatible_domain,
    ineligible_account_tier,
    missing_active_subsidiary_connection,
    incompatible_subsidiary_connection,
    incompatible_primary_partner,
    qualifications_association_limit_exceeded,
    qualifications_association_not_found,
    qualifications_association_exists,

    pub const json_field_names = .{
        .incompatible_connection_invitation_request = "INCOMPATIBLE_CONNECTION_INVITATION_REQUEST",
        .incompatible_legal_name = "INCOMPATIBLE_LEGAL_NAME",
        .incompatible_know_your_business_status = "INCOMPATIBLE_KNOW_YOUR_BUSINESS_STATUS",
        .incompatible_identity_verification_status = "INCOMPATIBLE_IDENTITY_VERIFICATION_STATUS",
        .invalid_account_linking_status = "INVALID_ACCOUNT_LINKING_STATUS",
        .invalid_account_state = "INVALID_ACCOUNT_STATE",
        .incompatible_domain = "INCOMPATIBLE_DOMAIN",
        .ineligible_account_tier = "INELIGIBLE_ACCOUNT_TIER",
        .missing_active_subsidiary_connection = "MISSING_ACTIVE_SUBSIDIARY_CONNECTION",
        .incompatible_subsidiary_connection = "INCOMPATIBLE_SUBSIDIARY_CONNECTION",
        .incompatible_primary_partner = "INCOMPATIBLE_PRIMARY_PARTNER",
        .qualifications_association_limit_exceeded = "QUALIFICATIONS_ASSOCIATION_LIMIT_EXCEEDED",
        .qualifications_association_not_found = "QUALIFICATIONS_ASSOCIATION_NOT_FOUND",
        .qualifications_association_exists = "QUALIFICATIONS_ASSOCIATION_EXISTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .incompatible_connection_invitation_request => "INCOMPATIBLE_CONNECTION_INVITATION_REQUEST",
            .incompatible_legal_name => "INCOMPATIBLE_LEGAL_NAME",
            .incompatible_know_your_business_status => "INCOMPATIBLE_KNOW_YOUR_BUSINESS_STATUS",
            .incompatible_identity_verification_status => "INCOMPATIBLE_IDENTITY_VERIFICATION_STATUS",
            .invalid_account_linking_status => "INVALID_ACCOUNT_LINKING_STATUS",
            .invalid_account_state => "INVALID_ACCOUNT_STATE",
            .incompatible_domain => "INCOMPATIBLE_DOMAIN",
            .ineligible_account_tier => "INELIGIBLE_ACCOUNT_TIER",
            .missing_active_subsidiary_connection => "MISSING_ACTIVE_SUBSIDIARY_CONNECTION",
            .incompatible_subsidiary_connection => "INCOMPATIBLE_SUBSIDIARY_CONNECTION",
            .incompatible_primary_partner => "INCOMPATIBLE_PRIMARY_PARTNER",
            .qualifications_association_limit_exceeded => "QUALIFICATIONS_ASSOCIATION_LIMIT_EXCEEDED",
            .qualifications_association_not_found => "QUALIFICATIONS_ASSOCIATION_NOT_FOUND",
            .qualifications_association_exists => "QUALIFICATIONS_ASSOCIATION_EXISTS",
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
