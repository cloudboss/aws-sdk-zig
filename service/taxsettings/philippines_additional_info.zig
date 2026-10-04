/// Additional tax information associated with your TRN in the Philippines.
pub const PhilippinesAdditionalInfo = struct {
    /// Indicates whether the account is VAT-registered with the Philippines Bureau
    /// of Internal Revenue (BIR).
    is_vat_registered: ?bool = null,

    pub const json_field_names = .{
        .is_vat_registered = "isVatRegistered",
    };
};
