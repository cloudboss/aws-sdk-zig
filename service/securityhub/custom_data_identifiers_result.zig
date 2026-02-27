const CustomDataIdentifiersDetections = @import("custom_data_identifiers_detections.zig").CustomDataIdentifiersDetections;

/// Contains an instance of sensitive data that was detected by a
/// customer-defined identifier.
pub const CustomDataIdentifiersResult = struct {
    /// The list of detected instances of sensitive data.
    detections: ?[]const CustomDataIdentifiersDetections,

    /// The total number of occurrences of sensitive data.
    total_count: ?i64,

    pub const json_field_names = .{
        .detections = "Detections",
        .total_count = "TotalCount",
    };
};
