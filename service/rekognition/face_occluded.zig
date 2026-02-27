/// `FaceOccluded` should return "true" with a high confidence score if a
/// detected
/// face’s eyes, nose, and mouth are partially captured or if they are covered
/// by masks, dark
/// sunglasses, cell phones, hands, or other objects. `FaceOccluded` should
/// return
/// "false" with a high confidence score if common occurrences that do not
/// impact face
/// verification are detected, such as eye glasses, lightly tinted sunglasses,
/// strands of hair,
/// and others.
///
/// You can use `FaceOccluded` to determine if an obstruction on a face
/// negatively
/// impacts using the image for face matching.
pub const FaceOccluded = struct {
    /// The confidence that the service has detected the presence of a face
    /// occlusion.
    confidence: ?f32,

    /// True if a detected face’s eyes, nose, and mouth are partially captured or if
    /// they are
    /// covered by masks, dark sunglasses, cell phones, hands, or other objects.
    /// False if common
    /// occurrences that do not impact face verification are detected, such as eye
    /// glasses, lightly
    /// tinted sunglasses, strands of hair, and others.
    value: bool = false,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .value = "Value",
    };
};
