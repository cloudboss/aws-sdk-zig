pub const InvoiceType = enum {
    invoice,
    credit_memo,

    pub const json_field_names = .{
        .invoice = "INVOICE",
        .credit_memo = "CREDIT_MEMO",
    };
};
