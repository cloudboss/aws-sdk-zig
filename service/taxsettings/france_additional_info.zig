/// Additional tax information associated with your TRN in France.
pub const FranceAdditionalInfo = struct {
    /// The routing code used for electronic invoicing (e-invoicing) for the company
    /// in France.
    e_invoice_routing_code: ?[]const u8 = null,

    /// The SIREN number for the company in France. Must be a 9-digit number.
    siren_number: []const u8,

    pub const json_field_names = .{
        .e_invoice_routing_code = "eInvoiceRoutingCode",
        .siren_number = "sirenNumber",
    };
};
