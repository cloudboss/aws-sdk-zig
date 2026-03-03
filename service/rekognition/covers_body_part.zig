/// Information about an item of Personal Protective Equipment covering a
/// corresponding body part. For more
/// information, see DetectProtectiveEquipment.
pub const CoversBodyPart = struct {
    /// The confidence that Amazon Rekognition has in the value of `Value`.
    confidence: ?f32 = null,

    /// True if the PPE covers the corresponding body part, otherwise false.
    value: bool = false,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .value = "Value",
    };
};
