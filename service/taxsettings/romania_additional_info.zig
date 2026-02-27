const TaxRegistrationNumberType = @import("tax_registration_number_type.zig").TaxRegistrationNumberType;

/// Additional tax information to specify for a TRN in Romania.
pub const RomaniaAdditionalInfo = struct {
    /// The tax registration number type. The value can be `TaxRegistrationNumber`
    /// or `LocalRegistrationNumber`.
    tax_registration_number_type: TaxRegistrationNumberType,

    pub const json_field_names = .{
        .tax_registration_number_type = "taxRegistrationNumberType",
    };
};
