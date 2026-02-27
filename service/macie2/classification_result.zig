const CustomDataIdentifiers = @import("custom_data_identifiers.zig").CustomDataIdentifiers;
const SensitiveDataItem = @import("sensitive_data_item.zig").SensitiveDataItem;
const ClassificationResultStatus = @import("classification_result_status.zig").ClassificationResultStatus;

/// Provides the details of a sensitive data finding, including the types,
/// number of occurrences, and locations of the sensitive data that was
/// detected.
pub const ClassificationResult = struct {
    /// Specifies whether Amazon Macie detected additional occurrences of sensitive
    /// data in the S3 object. A finding includes location data for a maximum of 15
    /// occurrences of sensitive data.
    ///
    /// This value can help you determine whether to investigate additional
    /// occurrences of sensitive data in an object. You can do this by referring to
    /// the corresponding sensitive data discovery result for the finding
    /// (classificationDetails.detailedResultsLocation).
    additional_occurrences: ?bool,

    /// The custom data identifiers that detected the sensitive data and the number
    /// of occurrences of the data that they detected.
    custom_data_identifiers: ?CustomDataIdentifiers,

    /// The type of content, as a MIME type, that the finding applies to. For
    /// example, application/gzip, for a GNU Gzip compressed archive file, or
    /// application/pdf, for an Adobe Portable Document Format file.
    mime_type: ?[]const u8,

    /// The category, types, and number of occurrences of the sensitive data that
    /// produced the finding.
    sensitive_data: ?[]const SensitiveDataItem,

    /// The total size, in bytes, of the data that the finding applies to.
    size_classified: ?i64,

    /// The status of the finding.
    status: ?ClassificationResultStatus,

    pub const json_field_names = .{
        .additional_occurrences = "additionalOccurrences",
        .custom_data_identifiers = "customDataIdentifiers",
        .mime_type = "mimeType",
        .sensitive_data = "sensitiveData",
        .size_classified = "sizeClassified",
        .status = "status",
    };
};
