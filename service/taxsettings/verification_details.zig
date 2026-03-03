const TaxRegistrationDocument = @import("tax_registration_document.zig").TaxRegistrationDocument;

/// Required information to verify your TRN.
pub const VerificationDetails = struct {
    /// Date of birth to verify your submitted TRN. Use the `YYYY-MM-DD` format.
    date_of_birth: ?[]const u8 = null,

    /// The tax registration document, which is required for specific countries such
    /// as Bangladesh, Kenya, South Korea and Spain.
    tax_registration_documents: ?[]const TaxRegistrationDocument = null,

    pub const json_field_names = .{
        .date_of_birth = "dateOfBirth",
        .tax_registration_documents = "taxRegistrationDocuments",
    };
};
