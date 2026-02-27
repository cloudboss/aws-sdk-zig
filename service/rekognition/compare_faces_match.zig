const ComparedFace = @import("compared_face.zig").ComparedFace;

/// Provides information about a face in a target image that matches the source
/// image face
/// analyzed by `CompareFaces`. The `Face` property contains the bounding
/// box of the face in the target image. The `Similarity` property is the
/// confidence
/// that the source image face matches the face in the bounding box.
pub const CompareFacesMatch = struct {
    /// Provides face metadata (bounding box and confidence that the bounding box
    /// actually
    /// contains a face).
    face: ?ComparedFace,

    /// Level of confidence that the faces match.
    similarity: ?f32,

    pub const json_field_names = .{
        .face = "Face",
        .similarity = "Similarity",
    };
};
