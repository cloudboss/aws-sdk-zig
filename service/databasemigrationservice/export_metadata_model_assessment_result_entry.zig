/// Provides information about an exported metadata model assessment.
pub const ExportMetadataModelAssessmentResultEntry = struct {
    /// The URL for the object containing the exported metadata model assessment.
    object_url: ?[]const u8 = null,

    /// The object key for the object containing the exported metadata model
    /// assessment.
    s3_object_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .object_url = "ObjectURL",
        .s3_object_key = "S3ObjectKey",
    };
};
