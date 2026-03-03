/// Document metadata files that contain information such as the document access
/// control
/// information, source URI, document author, and custom attributes. Each
/// metadata file
/// contains metadata about a single document.
pub const DocumentsMetadataConfiguration = struct {
    /// A prefix used to filter metadata configuration files in the Amazon Web
    /// Services S3
    /// bucket. The S3 bucket might contain multiple metadata files. Use `S3Prefix`
    /// to include only the desired metadata files.
    s3_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .s3_prefix = "S3Prefix",
    };
};
