const S3Configuration = @import("s3_configuration.zig").S3Configuration;

/// The location to write error reports for records rejected, asynchronously,
/// during
/// magnetic store writes.
pub const MagneticStoreRejectedDataLocation = struct {
    /// Configuration of an S3 location to write error reports for records rejected,
    /// asynchronously, during magnetic store writes.
    s3_configuration: ?S3Configuration,

    pub const json_field_names = .{
        .s3_configuration = "S3Configuration",
    };
};
