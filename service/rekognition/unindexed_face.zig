const FaceDetail = @import("face_detail.zig").FaceDetail;
const Reason = @import("reason.zig").Reason;

/// A face that IndexFaces detected, but didn't index. Use the
/// `Reasons` response attribute to determine why a face wasn't indexed.
pub const UnindexedFace = struct {
    /// The
    /// structure that contains attributes of a face that
    /// `IndexFaces`detected, but didn't index.
    face_detail: ?FaceDetail,

    /// An array of reasons that specify why a face wasn't indexed.
    ///
    /// * EXTREME_POSE - The face is at a pose that can't be detected. For example,
    ///   the head is
    /// turned too far away from the camera.
    ///
    /// * EXCEEDS_MAX_FACES - The number of faces detected is already higher than
    ///   that specified
    /// by the `MaxFaces` input parameter for `IndexFaces`.
    ///
    /// * LOW_BRIGHTNESS - The image is too dark.
    ///
    /// * LOW_SHARPNESS - The image is too blurry.
    ///
    /// * LOW_CONFIDENCE - The face was detected with a low confidence.
    ///
    /// * SMALL_BOUNDING_BOX - The bounding box around the face is too small.
    reasons: ?[]const Reason,

    pub const json_field_names = .{
        .face_detail = "FaceDetail",
        .reasons = "Reasons",
    };
};
