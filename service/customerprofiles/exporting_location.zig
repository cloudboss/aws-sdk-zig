const S3ExportingLocation = @import("s3_exporting_location.zig").S3ExportingLocation;

/// The S3 location where Identity Resolution Jobs write result files.
pub const ExportingLocation = struct {
    /// Information about the S3 location where Identity Resolution Jobs write
    /// result files.
    s3_exporting: ?S3ExportingLocation = null,

    pub const json_field_names = .{
        .s3_exporting = "S3Exporting",
    };
};
