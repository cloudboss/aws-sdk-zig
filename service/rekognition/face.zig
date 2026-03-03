const BoundingBox = @import("bounding_box.zig").BoundingBox;

/// Describes the face properties such as the bounding box, face ID, image ID of
/// the input
/// image, and external image ID that you assigned.
pub const Face = struct {
    /// Bounding box of the face.
    bounding_box: ?BoundingBox = null,

    /// Confidence level that the bounding box contains a face (and not a different
    /// object such
    /// as a tree).
    confidence: ?f32 = null,

    /// Identifier that you assign to all the faces in the input image.
    external_image_id: ?[]const u8 = null,

    /// Unique identifier that Amazon Rekognition assigns to the face.
    face_id: ?[]const u8 = null,

    /// Unique identifier that Amazon Rekognition assigns to the input image.
    image_id: ?[]const u8 = null,

    /// The version of the face detect and storage model that was used when indexing
    /// the face
    /// vector.
    index_faces_model_version: ?[]const u8 = null,

    /// Unique identifier assigned to the user.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .confidence = "Confidence",
        .external_image_id = "ExternalImageId",
        .face_id = "FaceId",
        .image_id = "ImageId",
        .index_faces_model_version = "IndexFacesModelVersion",
        .user_id = "UserId",
    };
};
