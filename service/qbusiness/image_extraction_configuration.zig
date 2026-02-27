const ImageExtractionStatus = @import("image_extraction_status.zig").ImageExtractionStatus;

/// The configuration for extracting semantic meaning from images in documents.
/// For more information, see [Extracting semantic meaning from images and
/// visuals](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/extracting-meaning-from-images.html).
pub const ImageExtractionConfiguration = struct {
    /// Specify whether to extract semantic meaning from images and visuals from
    /// documents.
    image_extraction_status: ImageExtractionStatus,

    pub const json_field_names = .{
        .image_extraction_status = "imageExtractionStatus",
    };
};
