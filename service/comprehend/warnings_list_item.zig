const PageBasedWarningCode = @import("page_based_warning_code.zig").PageBasedWarningCode;

/// The system identified one of the following warnings while processing the
/// input document:
///
/// * The document to classify is plain text, but the classifier is a native
///   document model.
///
/// * The document to classify is semi-structured, but the classifier is a
///   plain-text model.
pub const WarningsListItem = struct {
    /// Page number in the input document.
    page: ?i32 = null,

    /// The type of warning.
    warn_code: ?PageBasedWarningCode = null,

    /// Text message associated with the warning.
    warn_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .page = "Page",
        .warn_code = "WarnCode",
        .warn_message = "WarnMessage",
    };
};
