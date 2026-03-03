const std = @import("std");

pub const PiiEntityType = enum {
    bank_account_number,
    bank_routing,
    credit_debit_number,
    credit_debit_cvv,
    credit_debit_expiry,
    pin,
    email,
    address,
    name,
    phone,
    ssn,
    all,

    pub const json_field_names = .{
        .bank_account_number = "BANK_ACCOUNT_NUMBER",
        .bank_routing = "BANK_ROUTING",
        .credit_debit_number = "CREDIT_DEBIT_NUMBER",
        .credit_debit_cvv = "CREDIT_DEBIT_CVV",
        .credit_debit_expiry = "CREDIT_DEBIT_EXPIRY",
        .pin = "PIN",
        .email = "EMAIL",
        .address = "ADDRESS",
        .name = "NAME",
        .phone = "PHONE",
        .ssn = "SSN",
        .all = "ALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bank_account_number => "BANK_ACCOUNT_NUMBER",
            .bank_routing => "BANK_ROUTING",
            .credit_debit_number => "CREDIT_DEBIT_NUMBER",
            .credit_debit_cvv => "CREDIT_DEBIT_CVV",
            .credit_debit_expiry => "CREDIT_DEBIT_EXPIRY",
            .pin => "PIN",
            .email => "EMAIL",
            .address => "ADDRESS",
            .name => "NAME",
            .phone => "PHONE",
            .ssn => "SSN",
            .all => "ALL",
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
