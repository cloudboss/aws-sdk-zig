const std = @import("std");

pub const AccessDeniedExceptionReason = enum {
    invalid_account_state,
    denied_by_private_marketplace_policy,
    failed_kyc_compliance,
    missing_mfa,
    invalid_access,

    pub const json_field_names = .{
        .invalid_account_state = "INVALID_ACCOUNT_STATE",
        .denied_by_private_marketplace_policy = "DENIED_BY_PRIVATE_MARKETPLACE_POLICY",
        .failed_kyc_compliance = "FAILED_KYC_COMPLIANCE",
        .missing_mfa = "MISSING_MFA",
        .invalid_access = "INVALID_ACCESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_account_state => "INVALID_ACCOUNT_STATE",
            .denied_by_private_marketplace_policy => "DENIED_BY_PRIVATE_MARKETPLACE_POLICY",
            .failed_kyc_compliance => "FAILED_KYC_COMPLIANCE",
            .missing_mfa => "MISSING_MFA",
            .invalid_access => "INVALID_ACCESS",
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
