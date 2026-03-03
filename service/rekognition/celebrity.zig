const ComparedFace = @import("compared_face.zig").ComparedFace;
const KnownGender = @import("known_gender.zig").KnownGender;

/// Provides information about a celebrity recognized by the
/// RecognizeCelebrities operation.
pub const Celebrity = struct {
    /// Provides information about the celebrity's face, such as its location on the
    /// image.
    face: ?ComparedFace = null,

    /// A unique identifier for the celebrity.
    id: ?[]const u8 = null,

    known_gender: ?KnownGender = null,

    /// The confidence, in percentage, that Amazon Rekognition has that the
    /// recognized face is the
    /// celebrity.
    match_confidence: ?f32 = null,

    /// The name of the celebrity.
    name: ?[]const u8 = null,

    /// An array of URLs pointing to additional information about the celebrity. If
    /// there is no
    /// additional information about the celebrity, this list is empty.
    urls: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .face = "Face",
        .id = "Id",
        .known_gender = "KnownGender",
        .match_confidence = "MatchConfidence",
        .name = "Name",
        .urls = "Urls",
    };
};
