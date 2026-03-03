const std = @import("std");

pub const BusinessValidationCode = enum {
    incompatible_connection_invitation_request,
    incompatible_legal_name,
    incompatible_know_your_business_status,
    incompatible_identity_verification_status,
    invalid_account_linking_status,
    invalid_account_state,
    incompatible_domain,

    pub const json_field_names = .{
        .incompatible_connection_invitation_request = "INCOMPATIBLE_CONNECTION_INVITATION_REQUEST",
        .incompatible_legal_name = "INCOMPATIBLE_LEGAL_NAME",
        .incompatible_know_your_business_status = "INCOMPATIBLE_KNOW_YOUR_BUSINESS_STATUS",
        .incompatible_identity_verification_status = "INCOMPATIBLE_IDENTITY_VERIFICATION_STATUS",
        .invalid_account_linking_status = "INVALID_ACCOUNT_LINKING_STATUS",
        .invalid_account_state = "INVALID_ACCOUNT_STATE",
        .incompatible_domain = "INCOMPATIBLE_DOMAIN",
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
