const DocumentFormat = @import("document_format.zig").DocumentFormat;
const ReviewStatus = @import("review_status.zig").ReviewStatus;
const DocumentStatus = @import("document_status.zig").DocumentStatus;

/// Version information about the document.
pub const DocumentVersionInfo = struct {
    /// The date the document was created.
    created_date: ?i64,

    /// The friendly name of the SSM document. This value can differ for each
    /// version of the
    /// document. If you want to update this value, see UpdateDocument.
    display_name: ?[]const u8,

    /// The document format, either JSON or YAML.
    document_format: ?DocumentFormat,

    /// The document version.
    document_version: ?[]const u8,

    /// An identifier for the default version of the document.
    is_default_version: bool = false,

    /// The document name.
    name: ?[]const u8,

    /// The current status of the approval review for the latest version of the
    /// document.
    review_status: ?ReviewStatus,

    /// The status of the SSM document, such as `Creating`, `Active`,
    /// `Failed`, and `Deleting`.
    status: ?DocumentStatus,

    /// A message returned by Amazon Web Services Systems Manager that explains the
    /// `Status` value. For example, a
    /// `Failed` status might be explained by the `StatusInformation` message,
    /// "The specified S3 bucket doesn't exist. Verify that the URL of the S3 bucket
    /// is correct."
    status_information: ?[]const u8,

    /// The version of the artifact associated with the document. For example, 12.6.
    /// This value is
    /// unique across all versions of a document, and can't be changed.
    version_name: ?[]const u8,

    pub const json_field_names = .{
        .created_date = "CreatedDate",
        .display_name = "DisplayName",
        .document_format = "DocumentFormat",
        .document_version = "DocumentVersion",
        .is_default_version = "IsDefaultVersion",
        .name = "Name",
        .review_status = "ReviewStatus",
        .status = "Status",
        .status_information = "StatusInformation",
        .version_name = "VersionName",
    };
};
