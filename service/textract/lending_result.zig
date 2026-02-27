const Extraction = @import("extraction.zig").Extraction;
const PageClassification = @import("page_classification.zig").PageClassification;

/// Contains the detections for each page analyzed through the Analyze Lending
/// API.
pub const LendingResult = struct {
    /// An array of Extraction to hold structured data. e.g. normalized key value
    /// pairs instead of raw OCR detections .
    extractions: ?[]const Extraction,

    /// The page number for a page, with regard to whole submission.
    page: ?i32,

    /// The classifier result for a given page.
    page_classification: ?PageClassification,

    pub const json_field_names = .{
        .extractions = "Extractions",
        .page = "Page",
        .page_classification = "PageClassification",
    };
};
