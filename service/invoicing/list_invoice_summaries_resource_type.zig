pub const ListInvoiceSummariesResourceType = enum {
    account_id,
    invoice_id,

    pub const json_field_names = .{
        .account_id = "ACCOUNT_ID",
        .invoice_id = "INVOICE_ID",
    };
};
