/// The Amazon S3 location of the ZIP archive that contains the exported data
/// definition language (DDL) scripts.
pub const ExportSqlDetails = struct {
    /// The URL of the Amazon S3 object that contains the ZIP archive with exported
    /// DDL scripts.
    object_url: ?[]const u8 = null,

    /// The Amazon S3 URI of the object that contains the ZIP archive with exported
    /// DDL scripts.
    s3_object_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .object_url = "ObjectURL",
        .s3_object_key = "S3ObjectKey",
    };
};
