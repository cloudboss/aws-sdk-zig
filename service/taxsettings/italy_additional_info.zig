/// Additional tax information associated with your TRN in Italy.
pub const ItalyAdditionalInfo = struct {
    /// The tender procedure identification code.
    cig_number: ?[]const u8 = null,

    /// Additional tax information to specify for a TRN in Italy. This is managed by
    /// the Interministerial Committee for Economic Planning (CIPE) which
    /// characterizes every public investment project (Individual Project Code).
    cup_number: ?[]const u8 = null,

    /// Additional tax information to specify for a TRN in Italy. Use
    /// CodiceDestinatario to receive your invoices via web service (API) or FTP.
    sdi_account_id: ?[]const u8 = null,

    /// List of service tax codes for your TRN in Italy. You can use your customer
    /// tax code as part of a VAT Group.
    tax_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .cig_number = "cigNumber",
        .cup_number = "cupNumber",
        .sdi_account_id = "sdiAccountId",
        .tax_code = "taxCode",
    };
};
