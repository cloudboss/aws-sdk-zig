const DocumentClassifierMode = @import("document_classifier_mode.zig").DocumentClassifierMode;

/// Configuration required for a document classification model.
pub const DocumentClassificationConfig = struct {
    /// One or more labels to associate with the custom classifier.
    labels: ?[]const []const u8,

    /// Classification mode indicates whether the documents are `MULTI_CLASS` or
    /// `MULTI_LABEL`.
    mode: DocumentClassifierMode,

    pub const json_field_names = .{
        .labels = "Labels",
        .mode = "Mode",
    };
};
