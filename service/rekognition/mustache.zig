/// Indicates whether or not the face has a mustache, and the confidence level
/// in the
/// determination.
pub const Mustache = struct {
    /// Level of confidence in the determination.
    confidence: ?f32 = null,

    /// Boolean value that indicates whether the face has mustache or not.
    value: bool = false,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .value = "Value",
    };
};
