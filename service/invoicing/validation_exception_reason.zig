const std = @import("std");

pub const ValidationExceptionReason = enum {
    non_members_present,
    max_accounts_exceeded,
    max_invoice_units_exceeded,
    duplicate_invoice_unit,
    mutual_exclusion_error,
    account_membership_error,
    tax_settings_error,
    expired_next_token,
    invalid_next_token,
    invalid_input,
    field_validation_failed,
    cannot_parse,
    unknown_operation,
    other,

    pub const json_field_names = .{
        .non_members_present = "nonMemberPresent",
        .max_accounts_exceeded = "maxAccountsExceeded",
        .max_invoice_units_exceeded = "maxInvoiceUnitsExceeded",
        .duplicate_invoice_unit = "duplicateInvoiceUnit",
        .mutual_exclusion_error = "mutualExclusionError",
        .account_membership_error = "accountMembershipError",
        .tax_settings_error = "taxSettingsError",
        .expired_next_token = "expiredNextToken",
        .invalid_next_token = "invalidNextToken",
        .invalid_input = "invalidInput",
        .field_validation_failed = "fieldValidationFailed",
        .cannot_parse = "cannotParse",
        .unknown_operation = "unknownOperation",
        .other = "other",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .non_members_present => "nonMemberPresent",
            .max_accounts_exceeded => "maxAccountsExceeded",
            .max_invoice_units_exceeded => "maxInvoiceUnitsExceeded",
            .duplicate_invoice_unit => "duplicateInvoiceUnit",
            .mutual_exclusion_error => "mutualExclusionError",
            .account_membership_error => "accountMembershipError",
            .tax_settings_error => "taxSettingsError",
            .expired_next_token => "expiredNextToken",
            .invalid_next_token => "invalidNextToken",
            .invalid_input => "invalidInput",
            .field_validation_failed => "fieldValidationFailed",
            .cannot_parse => "cannotParse",
            .unknown_operation => "unknownOperation",
            .other => "other",
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
