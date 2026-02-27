const TaxRegistrationDocFile = @import("tax_registration_doc_file.zig").TaxRegistrationDocFile;
const SourceS3Location = @import("source_s3_location.zig").SourceS3Location;

/// Tax registration document information.
pub const TaxRegistrationDocument = struct {
    /// The tax registration document.
    file: ?TaxRegistrationDocFile,

    /// The Amazon S3 location where your tax registration document is stored.
    s_3_location: ?SourceS3Location,

    pub const json_field_names = .{
        .file = "file",
        .s_3_location = "s3Location",
    };
};
