const SaudiArabiaTaxRegistrationNumberType = @import("saudi_arabia_tax_registration_number_type.zig").SaudiArabiaTaxRegistrationNumberType;

/// Additional tax information associated with your TRN in Saudi Arabia.
pub const SaudiArabiaAdditionalInfo = struct {
    /// The tax registration number type.
    tax_registration_number_type: ?SaudiArabiaTaxRegistrationNumberType = null,

    pub const json_field_names = .{
        .tax_registration_number_type = "taxRegistrationNumberType",
    };
};
