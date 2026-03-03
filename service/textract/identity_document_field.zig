const AnalyzeIDDetections = @import("analyze_id_detections.zig").AnalyzeIDDetections;

/// Structure containing both the normalized type of the extracted information
/// and the text associated with it. These are extracted as Type and Value
/// respectively.
pub const IdentityDocumentField = struct {
    @"type": ?AnalyzeIDDetections = null,

    value_detection: ?AnalyzeIDDetections = null,

    pub const json_field_names = .{
        .@"type" = "Type",
        .value_detection = "ValueDetection",
    };
};
