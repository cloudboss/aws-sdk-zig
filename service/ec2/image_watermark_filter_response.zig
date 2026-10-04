/// The watermark filter criteria for an allowed image. Each entry can specify
/// one or more
/// fields. All specified fields must match the same watermark on the image.
pub const ImageWatermarkFilterResponse = struct {
    /// The maximum number of days that have elapsed since the source image was
    /// created.
    ///
    /// Constraints: Minimum value of 0. Maximum value of 2147483647.
    maximum_days_since_source_image_created: ?i32 = null,

    /// The maximum number of days that have elapsed since the watermark was
    /// attached to the
    /// image.
    ///
    /// Constraints: Minimum value of 0. Maximum value of 2147483647.
    maximum_days_since_watermark_created: ?i32 = null,

    /// The Region where the watermark was originally created. Supports wildcards
    /// (`*`,
    /// `?`).
    source_image_region: ?[]const u8 = null,

    /// The `accountId:name` of the watermark. Supports wildcards (`*`,
    /// `?`).
    watermark_key: ?[]const u8 = null,
};
