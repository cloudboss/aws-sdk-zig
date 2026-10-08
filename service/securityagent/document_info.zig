const IntegratedDocument = @import("integrated_document.zig").IntegratedDocument;

/// Represents a document that provides context for security testing.
pub const DocumentInfo = struct {
    /// The unique identifier of the artifact associated with the document.
    artifact_id: ?[]const u8 = null,

    /// A reference to a document in an integrated third-party provider.
    integrated_document: ?IntegratedDocument = null,

    /// The Amazon S3 location of the document.
    s_3_location: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifact_id = "artifactId",
        .integrated_document = "integratedDocument",
        .s_3_location = "s3Location",
    };
};
