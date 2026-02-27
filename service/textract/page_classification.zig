const Prediction = @import("prediction.zig").Prediction;

/// The class assigned to a Page object detected in an input document.
/// Contains information regarding the predicted type/class of a document's page
/// and the
/// page number that the Page object was detected on.
pub const PageClassification = struct {
    /// The page number the value was detected on, relative to Amazon Textract's
    /// starting position.
    page_number: []const Prediction,

    /// The class, or document type, assigned to a detected Page object. The class,
    /// or document type,
    /// assigned to a detected Page object.
    page_type: []const Prediction,

    pub const json_field_names = .{
        .page_number = "PageNumber",
        .page_type = "PageType",
    };
};
