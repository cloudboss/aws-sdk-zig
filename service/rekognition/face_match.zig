const Face = @import("face.zig").Face;

/// Provides face metadata. In addition, it also provides the confidence in the
/// match of
/// this face with the input face.
pub const FaceMatch = struct {
    /// Describes the face properties such as the bounding box, face ID, image ID of
    /// the source
    /// image, and external image ID that you assigned.
    face: ?Face = null,

    /// Confidence in the match of this face with the input face.
    similarity: ?f32 = null,

    pub const json_field_names = .{
        .face = "Face",
        .similarity = "Similarity",
    };
};
