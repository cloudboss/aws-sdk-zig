const ImageExtractionStatus = @import("image_extraction_status.zig").ImageExtractionStatus;

/// The configuration for image extraction from knowledge base documents.
pub const ImageExtractionConfiguration = struct {
    /// The status of image extraction. Valid values are ENABLED and DISABLED.
    image_extraction_status: ImageExtractionStatus,

    pub const json_field_names = .{
        .image_extraction_status = "imageExtractionStatus",
    };
};
