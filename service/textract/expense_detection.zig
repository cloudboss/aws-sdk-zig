const Geometry = @import("geometry.zig").Geometry;

/// An object used to store information about the Value or Label detected by
/// Amazon Textract.
pub const ExpenseDetection = struct {
    /// The confidence in detection, as a percentage
    confidence: ?f32 = null,

    geometry: ?Geometry = null,

    /// The word or line of text recognized by Amazon Textract
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .geometry = "Geometry",
        .text = "Text",
    };
};
