const CustomDetection = @import("custom_detection.zig").CustomDetection;

/// Provides information about custom data identifiers that produced a sensitive
/// data finding, and the number of occurrences of the data that they detected
/// for the finding.
pub const CustomDataIdentifiers = struct {
    /// The custom data identifiers that detected the data, and the number of
    /// occurrences of the data that each identifier detected.
    detections: ?[]const CustomDetection = null,

    /// The total number of occurrences of the data that was detected by the custom
    /// data identifiers and produced the finding.
    total_count: ?i64 = null,

    pub const json_field_names = .{
        .detections = "detections",
        .total_count = "totalCount",
    };
};
