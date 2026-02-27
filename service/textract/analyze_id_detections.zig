const NormalizedValue = @import("normalized_value.zig").NormalizedValue;

/// Used to contain the information detected by an AnalyzeID operation.
pub const AnalyzeIDDetections = struct {
    /// The confidence score of the detected text.
    confidence: ?f32,

    /// Only returned for dates, returns the type of value detected and the date
    /// written in a more machine readable way.
    normalized_value: ?NormalizedValue,

    /// Text of either the normalized field or value associated with it.
    text: []const u8,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .normalized_value = "NormalizedValue",
        .text = "Text",
    };
};
