const std = @import("std");

pub const SupplementalDocumentType = enum {
    government_invoice,
    tax_e_invoice,
    payment_receipt,
    supplement,

    pub const json_field_names = .{
        .government_invoice = "GOVERNMENT_INVOICE",
        .tax_e_invoice = "TAX_E_INVOICE",
        .payment_receipt = "PAYMENT_RECEIPT",
        .supplement = "SUPPLEMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .government_invoice => "GOVERNMENT_INVOICE",
            .tax_e_invoice => "TAX_E_INVOICE",
            .payment_receipt => "PAYMENT_RECEIPT",
            .supplement => "SUPPLEMENT",
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
