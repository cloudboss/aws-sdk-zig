const SensitiveDataItemCategory = @import("sensitive_data_item_category.zig").SensitiveDataItemCategory;
const DefaultDetection = @import("default_detection.zig").DefaultDetection;

/// Provides information about the category, types, and occurrences of sensitive
/// data that produced a sensitive data finding.
pub const SensitiveDataItem = struct {
    /// The category of sensitive data that was detected. For example: CREDENTIALS,
    /// for credentials data such as private keys or Amazon Web Services secret
    /// access keys; FINANCIAL_INFORMATION, for financial data such as credit card
    /// numbers; or, PERSONAL_INFORMATION, for personal health information, such as
    /// health insurance identification numbers, or personally identifiable
    /// information, such as passport numbers.
    category: ?SensitiveDataItemCategory,

    /// An array of objects, one for each type of sensitive data that was detected.
    /// Each object reports the number of occurrences of a specific type of
    /// sensitive data that was detected, and the location of up to 15 of those
    /// occurrences.
    detections: ?[]const DefaultDetection,

    /// The total number of occurrences of the sensitive data that was detected.
    total_count: ?i64,

    pub const json_field_names = .{
        .category = "category",
        .detections = "detections",
        .total_count = "totalCount",
    };
};
