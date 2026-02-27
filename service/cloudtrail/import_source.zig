const S3ImportSource = @import("s3_import_source.zig").S3ImportSource;

/// The import source.
pub const ImportSource = struct {
    /// The source S3 bucket.
    s3: S3ImportSource,

    pub const json_field_names = .{
        .s3 = "S3",
    };
};
