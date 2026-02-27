/// Indicates whether or not the face is wearing sunglasses, and the confidence
/// level in
/// the determination.
pub const Sunglasses = struct {
    /// Level of confidence in the determination.
    confidence: ?f32,

    /// Boolean value that indicates whether the face is wearing sunglasses or not.
    value: bool = false,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .value = "Value",
    };
};
