const S3Location = @import("s3_location.zig").S3Location;

/// The source for an image.
pub const ImageSource = union(enum) {
    /// The raw image bytes for the image. If you use an Amazon Web Services SDK,
    /// you don't need to encode the image bytes in base64.
    bytes: ?[]const u8,
    /// The path to the Amazon S3 bucket where the image is stored.
    s_3_location: ?S3Location,

    pub const json_field_names = .{
        .bytes = "bytes",
        .s_3_location = "s3Location",
    };
};
