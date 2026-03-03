/// Indicates whether or not the eyes on the face are open, and the confidence
/// level in the
/// determination.
pub const EyeOpen = struct {
    /// Level of confidence in the determination.
    confidence: ?f32 = null,

    /// Boolean value that indicates whether the eyes on the face are open.
    value: bool = false,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .value = "Value",
    };
};
