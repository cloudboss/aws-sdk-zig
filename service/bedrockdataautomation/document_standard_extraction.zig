const DocumentBoundingBox = @import("document_bounding_box.zig").DocumentBoundingBox;
const DocumentExtractionGranularity = @import("document_extraction_granularity.zig").DocumentExtractionGranularity;

/// Standard Extraction Configuration of Document
pub const DocumentStandardExtraction = struct {
    bounding_box: DocumentBoundingBox,

    granularity: DocumentExtractionGranularity,

    pub const json_field_names = .{
        .bounding_box = "boundingBox",
        .granularity = "granularity",
    };
};
