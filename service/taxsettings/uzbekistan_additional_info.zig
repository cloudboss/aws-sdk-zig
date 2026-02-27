const UzbekistanTaxRegistrationNumberType = @import("uzbekistan_tax_registration_number_type.zig").UzbekistanTaxRegistrationNumberType;

/// Additional tax information to specify for a TRN in Uzbekistan.
pub const UzbekistanAdditionalInfo = struct {
    /// The tax registration number type. The tax registration number type valid
    /// values are `Business` and `Individual`.
    tax_registration_number_type: ?UzbekistanTaxRegistrationNumberType,

    /// The unique 12-digit number issued to identify VAT-registered identities in
    /// Uzbekistan.
    vat_registration_number: ?[]const u8,

    pub const json_field_names = .{
        .tax_registration_number_type = "taxRegistrationNumberType",
        .vat_registration_number = "vatRegistrationNumber",
    };
};
