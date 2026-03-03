/// The information about the revision of the SNOMED-CT ontology in the
/// response. Specifically, the details include the SNOMED-CT edition, language,
/// and version date.
pub const SNOMEDCTDetails = struct {
    /// The edition of SNOMED-CT used. The edition used for the InferSNOMEDCT
    /// editions is the US edition.
    edition: ?[]const u8 = null,

    /// The language used in the SNOMED-CT ontology. All Amazon Comprehend Medical
    /// operations are US English (en).
    language: ?[]const u8 = null,

    /// The version date of the SNOMED-CT ontology used.
    version_date: ?[]const u8 = null,

    pub const json_field_names = .{
        .edition = "Edition",
        .language = "Language",
        .version_date = "VersionDate",
    };
};
