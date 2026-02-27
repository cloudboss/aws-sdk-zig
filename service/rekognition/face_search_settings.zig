/// Input face recognition parameters for an Amazon Rekognition stream
/// processor.
/// Includes the collection to use for face recognition and the face attributes
/// to detect.
/// Defining the settings is required in the request parameter for
/// CreateStreamProcessor.
pub const FaceSearchSettings = struct {
    /// The ID of a collection that contains faces that you want to search for.
    collection_id: ?[]const u8,

    /// Minimum face match confidence score that must be met to return a result for
    /// a recognized face. The default is 80.
    /// 0 is the lowest confidence. 100 is the highest confidence. Values between 0
    /// and 100 are accepted, and values lower than 80 are set to 80.
    face_match_threshold: ?f32,

    pub const json_field_names = .{
        .collection_id = "CollectionId",
        .face_match_threshold = "FaceMatchThreshold",
    };
};
