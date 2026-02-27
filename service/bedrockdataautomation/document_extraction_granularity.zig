const DocumentExtractionGranularityType = @import("document_extraction_granularity_type.zig").DocumentExtractionGranularityType;

/// Granularity of Document Extraction
pub const DocumentExtractionGranularity = struct {
    types: ?[]const DocumentExtractionGranularityType,

    pub const json_field_names = .{
        .types = "types",
    };
};
