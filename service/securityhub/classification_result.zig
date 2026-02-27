const CustomDataIdentifiersResult = @import("custom_data_identifiers_result.zig").CustomDataIdentifiersResult;
const SensitiveDataResult = @import("sensitive_data_result.zig").SensitiveDataResult;
const ClassificationStatus = @import("classification_status.zig").ClassificationStatus;

/// Details about the sensitive data that was detected on the resource.
pub const ClassificationResult = struct {
    /// Indicates whether there are additional occurrences of sensitive data that
    /// are not included in the finding. This occurs when the number of occurrences
    /// exceeds the maximum that can be included.
    additional_occurrences: ?bool,

    /// Provides details about sensitive data that was identified based on
    /// customer-defined configuration.
    custom_data_identifiers: ?CustomDataIdentifiersResult,

    /// The type of content that the finding applies to.
    mime_type: ?[]const u8,

    /// Provides details about sensitive data that was identified based on built-in
    /// configuration.
    sensitive_data: ?[]const SensitiveDataResult,

    /// The total size in bytes of the affected data.
    size_classified: ?i64,

    /// The current status of the sensitive data detection.
    status: ?ClassificationStatus,

    pub const json_field_names = .{
        .additional_occurrences = "AdditionalOccurrences",
        .custom_data_identifiers = "CustomDataIdentifiers",
        .mime_type = "MimeType",
        .sensitive_data = "SensitiveData",
        .size_classified = "SizeClassified",
        .status = "Status",
    };
};
