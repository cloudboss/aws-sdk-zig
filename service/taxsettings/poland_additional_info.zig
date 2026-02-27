/// Additional tax information associated with your TRN in Poland.
pub const PolandAdditionalInfo = struct {
    /// The individual tax registration number (NIP). Individual NIP is valid for
    /// other taxes excluding VAT purposes.
    individual_registration_number: ?[]const u8,

    /// True if your business is a member of a VAT group with a NIP active for VAT
    /// purposes. Otherwise, this is false.
    is_group_vat_enabled: ?bool,

    pub const json_field_names = .{
        .individual_registration_number = "individualRegistrationNumber",
        .is_group_vat_enabled = "isGroupVatEnabled",
    };
};
