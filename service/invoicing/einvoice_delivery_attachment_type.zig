pub const EinvoiceDeliveryAttachmentType = enum {
    invoice_pdf,
    rfp_pdf,

    pub const json_field_names = .{
        .invoice_pdf = "INVOICE_PDF",
        .rfp_pdf = "RFP_PDF",
    };
};
