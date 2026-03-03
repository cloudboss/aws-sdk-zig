const FaceMatch = @import("face_match.zig").FaceMatch;
const PersonDetail = @import("person_detail.zig").PersonDetail;

/// Information about a person whose face matches a face(s) in an Amazon
/// Rekognition collection.
/// Includes information about the faces in the Amazon Rekognition collection
/// (FaceMatch), information about the person (PersonDetail), and the time stamp
/// for
/// when the person was detected in a video. An array of `PersonMatch` objects
/// is
/// returned by GetFaceSearch.
pub const PersonMatch = struct {
    /// Information about the faces in the input collection that match the face of a
    /// person in the
    /// video.
    face_matches: ?[]const FaceMatch = null,

    /// Information about the matched person.
    person: ?PersonDetail = null,

    /// The time, in milliseconds from the beginning of the video, that the person
    /// was matched in
    /// the video.
    timestamp: i64 = 0,

    pub const json_field_names = .{
        .face_matches = "FaceMatches",
        .person = "Person",
        .timestamp = "Timestamp",
    };
};
