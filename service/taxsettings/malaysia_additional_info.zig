const MalaysiaServiceTaxCode = @import("malaysia_service_tax_code.zig").MalaysiaServiceTaxCode;

/// Additional tax information associated with your TRN in Malaysia.
pub const MalaysiaAdditionalInfo = struct {
    /// The tax registration number (TRN) in Malaysia.
    ///
    /// For individual, you can specify the `taxInformationNumber` in
    /// `MalaysiaAdditionalInfo` with NRIC type, and a valid MyKad or NRIC number.
    /// For business, you must specify a `businessRegistrationNumber` in
    /// `MalaysiaAdditionalInfo` with a TIN type and tax identification number. For
    /// business resellers, you must specify a `businessRegistrationNumber` and
    /// `taxInformationNumber` in `MalaysiaAdditionalInfo` with a sales and service
    /// tax (SST) type and a valid SST number.
    ///
    /// For business resellers with service codes, you must specify
    /// `businessRegistrationNumber`, `taxInformationNumber`, and distinct
    /// `serviceTaxCodes` in `MalaysiaAdditionalInfo` with a SST type and valid
    /// sales and service tax (SST) number. By using this API operation, Amazon Web
    /// Services registers your self-declaration that you’re an authorized business
    /// reseller registered with the Royal Malaysia Customs Department (RMCD), and
    /// have a valid SST number.
    business_registration_number: ?[]const u8 = null,

    /// List of service tax codes for your TRN in Malaysia.
    service_tax_codes: []const MalaysiaServiceTaxCode = &.{},

    /// The tax information number in Malaysia.
    ///
    /// For individual, you can specify the `taxInformationNumber` in
    /// `MalaysiaAdditionalInfo` with NRIC type, and a valid MyKad or NRIC number.
    /// For business resellers, you must specify a `businessRegistrationNumber` and
    /// `taxInformationNumber` in `MalaysiaAdditionalInfo` with a sales and service
    /// tax (SST) type and a valid SST number.
    ///
    /// For business resellers with service codes, you must specify
    /// `businessRegistrationNumber`, `taxInformationNumber`, and distinct
    /// `serviceTaxCodes` in `MalaysiaAdditionalInfo` with a SST type and valid
    /// sales and service tax (SST) number. By using this API operation, Amazon Web
    /// Services registers your self-declaration that you’re an authorized business
    /// reseller registered with the Royal Malaysia Customs Department (RMCD), and
    /// have a valid SST number.
    tax_information_number: ?[]const u8 = null,

    pub const json_field_names = .{
        .business_registration_number = "businessRegistrationNumber",
        .service_tax_codes = "serviceTaxCodes",
        .tax_information_number = "taxInformationNumber",
    };
};
