const std = @import("std");

pub const InvoiceType = enum {
    invoice,
    credit_memo,
    payment_receipt,

    pub const json_field_names = .{
        .invoice = "INVOICE",
        .credit_memo = "CREDIT_MEMO",
        .payment_receipt = "PAYMENT_RECEIPT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invoice => "INVOICE",
            .credit_memo => "CREDIT_MEMO",
            .payment_receipt => "PAYMENT_RECEIPT",
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
