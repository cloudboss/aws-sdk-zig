const BoundingBox = @import("bounding_box.zig").BoundingBox;

/// Type that describes the face Amazon Rekognition chose to compare with the
/// faces in the target.
/// This contains a bounding box for the selected face and confidence level that
/// the bounding box
/// contains a face. Note that Amazon Rekognition selects the largest face in
/// the source image for this
/// comparison.
pub const ComparedSourceImageFace = struct {
    /// Bounding box of the face.
    bounding_box: ?BoundingBox,

    /// Confidence level that the selected bounding box contains a face.
    confidence: ?f32,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .confidence = "Confidence",
    };
};
