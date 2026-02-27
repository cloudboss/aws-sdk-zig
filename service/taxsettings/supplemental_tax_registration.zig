const Address = @import("address.zig").Address;
const SupplementalTaxRegistrationType = @import("supplemental_tax_registration_type.zig").SupplementalTaxRegistrationType;
const TaxRegistrationStatus = @import("tax_registration_status.zig").TaxRegistrationStatus;

/// Supplemental TRN details.
pub const SupplementalTaxRegistration = struct {
    address: Address,

    /// Unique authority ID for the supplemental TRN.
    authority_id: []const u8,

    /// The legal name associated with your TRN registration.
    legal_name: []const u8,

    /// The supplemental TRN unique identifier.
    registration_id: []const u8,

    /// Type of supplemental TRN. Currently, this can only be VAT.
    registration_type: SupplementalTaxRegistrationType,

    /// The status of your TRN.
    status: TaxRegistrationStatus,

    pub const json_field_names = .{
        .address = "address",
        .authority_id = "authorityId",
        .legal_name = "legalName",
        .registration_id = "registrationId",
        .registration_type = "registrationType",
        .status = "status",
    };
};
