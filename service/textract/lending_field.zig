const LendingDetection = @import("lending_detection.zig").LendingDetection;

/// Holds the normalized key-value pairs returned by AnalyzeDocument, including
/// the document type, detected text, and geometry.
pub const LendingField = struct {
    key_detection: ?LendingDetection = null,

    /// The type of the lending document.
    @"type": ?[]const u8 = null,

    /// An array of LendingDetection objects.
    value_detections: ?[]const LendingDetection = null,

    pub const json_field_names = .{
        .key_detection = "KeyDetection",
        .@"type" = "Type",
        .value_detections = "ValueDetections",
    };
};
