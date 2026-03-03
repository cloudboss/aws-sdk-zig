const AdditionalInfoRequest = @import("additional_info_request.zig").AdditionalInfoRequest;
const Address = @import("address.zig").Address;
const TaxRegistrationType = @import("tax_registration_type.zig").TaxRegistrationType;
const Sector = @import("sector.zig").Sector;
const VerificationDetails = @import("verification_details.zig").VerificationDetails;

/// The TRN information you provide when you add a new TRN, or update.
pub const TaxRegistrationEntry = struct {
    /// Additional tax information associated with your TRN. You only need to
    /// specify this
    /// parameter if Amazon Web Services collects any additional information for
    /// your country within
    /// AdditionalInfoRequest.
    additional_tax_information: ?AdditionalInfoRequest = null,

    /// The email address to receive VAT invoices.
    certified_email_id: ?[]const u8 = null,

    /// The legal address associated with your TRN.
    ///
    /// If you're setting a TRN in Brazil for the CNPJ tax type, you don't need to
    /// specify the
    /// legal address.
    ///
    /// For TRNs in other countries and for CPF tax types Brazil, you must specify
    /// the legal
    /// address.
    legal_address: ?Address = null,

    /// The legal name associated with your TRN.
    ///
    /// If you're setting a TRN in Brazil, you don't need to specify the legal name.
    /// For TRNs in
    /// other countries, you must specify the legal name.
    legal_name: ?[]const u8 = null,

    /// Your tax registration unique identifier.
    registration_id: []const u8,

    /// Your tax registration type. This can be either `VAT` or `GST`.
    registration_type: TaxRegistrationType,

    /// The industry that describes your business. For business-to-business (B2B)
    /// customers, specify Business. For business-to-consumer (B2C) customers,
    /// specify Individual. For business-to-government (B2G), specify
    /// Government.Note that certain values may not applicable for the request
    /// country. Please refer to country specific information in API document.
    sector: ?Sector = null,

    /// Additional details needed to verify your TRN information in Brazil. You only
    /// need to specify this
    /// parameter when you set a TRN in Brazil that is the CPF tax type.
    ///
    /// Don't specify this parameter to set a TRN in Brazil of the CNPJ tax type or
    /// to set a TRN
    /// for another country.
    verification_details: ?VerificationDetails = null,

    pub const json_field_names = .{
        .additional_tax_information = "additionalTaxInformation",
        .certified_email_id = "certifiedEmailId",
        .legal_address = "legalAddress",
        .legal_name = "legalName",
        .registration_id = "registrationId",
        .registration_type = "registrationType",
        .sector = "sector",
        .verification_details = "verificationDetails",
    };
};
