/// Indicates whether or not the mouth on the face is open, and the confidence
/// level in the
/// determination.
pub const MouthOpen = struct {
    /// Level of confidence in the determination.
    confidence: ?f32 = null,

    /// Boolean value that indicates whether the mouth on the face is open or not.
    value: bool = false,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .value = "Value",
    };
};
