const std = @import("std");

pub const AgreementEntitlementStatusReasonCode = enum {
    provisioning_in_progress,
    future_start_date,
    invalid_payment_instrument,
    incompatible_currency,
    account_suspended,
    unsupported_operation,
    agreement_inactive,
    agreement_active,
    product_restricted,

    pub const json_field_names = .{
        .provisioning_in_progress = "PROVISIONING_IN_PROGRESS",
        .future_start_date = "FUTURE_START_DATE",
        .invalid_payment_instrument = "INVALID_PAYMENT_INSTRUMENT",
        .incompatible_currency = "INCOMPATIBLE_CURRENCY",
        .account_suspended = "ACCOUNT_SUSPENDED",
        .unsupported_operation = "UNSUPPORTED_OPERATION",
        .agreement_inactive = "AGREEMENT_INACTIVE",
        .agreement_active = "AGREEMENT_ACTIVE",
        .product_restricted = "PRODUCT_RESTRICTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .provisioning_in_progress => "PROVISIONING_IN_PROGRESS",
            .future_start_date => "FUTURE_START_DATE",
            .invalid_payment_instrument => "INVALID_PAYMENT_INSTRUMENT",
            .incompatible_currency => "INCOMPATIBLE_CURRENCY",
            .account_suspended => "ACCOUNT_SUSPENDED",
            .unsupported_operation => "UNSUPPORTED_OPERATION",
            .agreement_inactive => "AGREEMENT_INACTIVE",
            .agreement_active => "AGREEMENT_ACTIVE",
            .product_restricted => "PRODUCT_RESTRICTED",
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
