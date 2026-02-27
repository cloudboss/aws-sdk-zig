const Address = @import("address.zig").Address;
const SupplementalTaxRegistrationType = @import("supplemental_tax_registration_type.zig").SupplementalTaxRegistrationType;

/// The supplemental TRN information to provide when adding or updating a
/// supplemental TRN.
pub const SupplementalTaxRegistrationEntry = struct {
    address: Address,

    /// The legal name associated with your TRN registration.
    legal_name: []const u8,

    /// The supplemental TRN unique identifier.
    registration_id: []const u8,

    /// Type of supplemental TRN. Currently, this can only be VAT.
    registration_type: SupplementalTaxRegistrationType,

    pub const json_field_names = .{
        .address = "address",
        .legal_name = "legalName",
        .registration_id = "registrationId",
        .registration_type = "registrationType",
    };
};
