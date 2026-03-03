const GenderType = @import("gender_type.zig").GenderType;

/// The predicted gender of a detected face.
///
/// Amazon Rekognition makes gender binary (male/female) predictions based on
/// the physical
/// appearance of a face in a particular image. This kind of prediction is not
/// designed to
/// categorize a person’s gender identity, and you shouldn't use Amazon
/// Rekognition to make such a
/// determination. For example, a male actor wearing a long-haired wig and
/// earrings for a role
/// might be predicted as female.
///
/// Using Amazon Rekognition to make gender binary predictions is best suited
/// for use cases
/// where aggregate gender distribution statistics need to be analyzed without
/// identifying
/// specific users. For example, the percentage of female users compared to male
/// users on a social
/// media platform.
///
/// We don't recommend using gender binary predictions to make decisions that
/// impact an
/// individual's rights, privacy, or access to services.
pub const Gender = struct {
    /// Level of confidence in the prediction.
    confidence: ?f32 = null,

    /// The predicted gender of the face.
    value: ?GenderType = null,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .value = "Value",
    };
};
