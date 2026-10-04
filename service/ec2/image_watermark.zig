/// Describes a watermark attached to an AMI.
pub const ImageWatermark = struct {
    /// The creation date of the source AMI, in the
    /// following format:
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*.*ssssss*+*HH*:*MM*.
    source_image_creation_time: ?i64 = null,

    /// The ID of the AMI to which the watermark was originally attached.
    source_image_id: ?[]const u8 = null,

    /// The Region where the watermark was originally attached.
    source_image_region: ?[]const u8 = null,

    /// The date and time the watermark was attached to the AMI, in the following
    /// format:
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*.*ssssss*+*HH*:*MM*.
    watermark_creation_time: ?i64 = null,

    /// The watermark identifier, in `accountId:watermarkName` format (for example,
    /// `123456789012:approvedAmi`). The `accountId` portion is the Amazon Web
    /// Services account
    /// ID of the watermark creator. The `watermarkName` portion is
    /// customer-provided.
    watermark_key: ?[]const u8 = null,
};
