const SensitiveDataDetections = @import("sensitive_data_detections.zig").SensitiveDataDetections;

/// Contains a detected instance of sensitive data that are based on built-in
/// identifiers.
pub const SensitiveDataResult = struct {
    /// The category of sensitive data that was detected. For example, the category
    /// can indicate that the sensitive data involved credentials, financial
    /// information, or personal information.
    category: ?[]const u8 = null,

    /// The list of detected instances of sensitive data.
    detections: ?[]const SensitiveDataDetections = null,

    /// The total number of occurrences of sensitive data.
    total_count: ?i64 = null,

    pub const json_field_names = .{
        .category = "Category",
        .detections = "Detections",
        .total_count = "TotalCount",
    };
};
