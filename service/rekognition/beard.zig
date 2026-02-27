/// Indicates whether or not the face has a beard, and the confidence level in
/// the
/// determination.
pub const Beard = struct {
    /// Level of confidence in the determination.
    confidence: ?f32,

    /// Boolean value that indicates whether the face has beard or not.
    value: bool = false,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .value = "Value",
    };
};
