const AdditionalInfoResponse = @import("additional_info_response.zig").AdditionalInfoResponse;
const Address = @import("address.zig").Address;
const TaxRegistrationType = @import("tax_registration_type.zig").TaxRegistrationType;
const Sector = @import("sector.zig").Sector;
const TaxRegistrationStatus = @import("tax_registration_status.zig").TaxRegistrationStatus;
const TaxDocumentMetadata = @import("tax_document_metadata.zig").TaxDocumentMetadata;

/// Your TRN information.
pub const TaxRegistration = struct {
    /// Additional tax information associated with your TRN.
    additional_tax_information: ?AdditionalInfoResponse,

    /// The email address to receive VAT invoices.
    certified_email_id: ?[]const u8,

    /// The legal address associated with your TRN registration.
    legal_address: Address,

    /// The legal name associated with your TRN registration.
    legal_name: []const u8,

    /// Your tax registration unique identifier.
    registration_id: []const u8,

    /// Type of your tax registration.
    registration_type: TaxRegistrationType,

    /// The industry that describes your business. For business-to-business (B2B)
    /// customers, specify Business. For business-to-consumer (B2C) customers,
    /// specify Individual. For business-to-government (B2G), specify Government.
    /// Note that certain values may not applicable for the request country. Please
    /// refer to country specific information in API document.
    sector: ?Sector,

    /// The status of your TRN. This can be either `Verified`, `Pending`,
    /// `Deleted`, or `Rejected`.
    status: TaxRegistrationStatus,

    /// The metadata for your tax document.
    tax_document_metadatas: ?[]const TaxDocumentMetadata,

    pub const json_field_names = .{
        .additional_tax_information = "additionalTaxInformation",
        .certified_email_id = "certifiedEmailId",
        .legal_address = "legalAddress",
        .legal_name = "legalName",
        .registration_id = "registrationId",
        .registration_type = "registrationType",
        .sector = "sector",
        .status = "status",
        .tax_document_metadatas = "taxDocumentMetadatas",
    };
};
