const S3ContentLocationUpdate = @import("s3_content_location_update.zig").S3ContentLocationUpdate;

/// Describes an update to the code of an application. Not supported for Apache
/// Zeppelin.
pub const CodeContentUpdate = struct {
    /// Describes an update to the location of code for an application.
    s3_content_location_update: ?S3ContentLocationUpdate = null,

    /// Describes an update to the text code for an application.
    text_content_update: ?[]const u8 = null,

    /// Describes an update to the zipped code for an application.
    zip_file_content_update: ?[]const u8 = null,

    pub const json_field_names = .{
        .s3_content_location_update = "S3ContentLocationUpdate",
        .text_content_update = "TextContentUpdate",
        .zip_file_content_update = "ZipFileContentUpdate",
    };
};
