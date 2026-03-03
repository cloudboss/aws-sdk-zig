const BoundingBox = @import("bounding_box.zig").BoundingBox;
const FaceDetail = @import("face_detail.zig").FaceDetail;
const KnownGender = @import("known_gender.zig").KnownGender;

/// Information about a recognized celebrity.
pub const CelebrityDetail = struct {
    /// Bounding box around the body of a celebrity.
    bounding_box: ?BoundingBox = null,

    /// The confidence, in percentage, that Amazon Rekognition has that the
    /// recognized face is the celebrity.
    confidence: ?f32 = null,

    /// Face details for the recognized celebrity.
    face: ?FaceDetail = null,

    /// The unique identifier for the celebrity.
    id: ?[]const u8 = null,

    /// Retrieves the known gender for the celebrity.
    known_gender: ?KnownGender = null,

    /// The name of the celebrity.
    name: ?[]const u8 = null,

    /// An array of URLs pointing to additional celebrity information.
    urls: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .confidence = "Confidence",
        .face = "Face",
        .id = "Id",
        .known_gender = "KnownGender",
        .name = "Name",
        .urls = "Urls",
    };
};
