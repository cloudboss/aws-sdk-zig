const ModelStatus = @import("model_status.zig").ModelStatus;

/// Provides information for filtering a list of document classifiers. You can
/// only specify
/// one filtering parameter in a request. For more information, see the
/// `ListDocumentClassifiers` operation.
pub const DocumentClassifierFilter = struct {
    /// The name that you assigned to the document classifier
    document_classifier_name: ?[]const u8,

    /// Filters the list of classifiers based on status.
    status: ?ModelStatus,

    /// Filters the list of classifiers based on the time that the classifier was
    /// submitted for
    /// processing. Returns only classifiers submitted after the specified time.
    /// Classifiers are
    /// returned in descending order, newest to oldest.
    submit_time_after: ?i64,

    /// Filters the list of classifiers based on the time that the classifier was
    /// submitted for
    /// processing. Returns only classifiers submitted before the specified time.
    /// Classifiers are
    /// returned in ascending order, oldest to newest.
    submit_time_before: ?i64,

    pub const json_field_names = .{
        .document_classifier_name = "DocumentClassifierName",
        .status = "Status",
        .submit_time_after = "SubmitTimeAfter",
        .submit_time_before = "SubmitTimeBefore",
    };
};
