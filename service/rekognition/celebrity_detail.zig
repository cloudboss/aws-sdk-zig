const BoundingBox = @import("bounding_box.zig").BoundingBox;
const FaceDetail = @import("face_detail.zig").FaceDetail;
const KnownGender = @import("known_gender.zig").KnownGender;

/// Information about a recognized celebrity.
pub const CelebrityDetail = struct {
    /// Bounding box around the body of a celebrity.
    bounding_box: ?BoundingBox,

    /// The confidence, in percentage, that Amazon Rekognition has that the
    /// recognized face is the celebrity.
    confidence: ?f32,

    /// Face details for the recognized celebrity.
    face: ?FaceDetail,

    /// The unique identifier for the celebrity.
    id: ?[]const u8,

    /// Retrieves the known gender for the celebrity.
    known_gender: ?KnownGender,

    /// The name of the celebrity.
    name: ?[]const u8,

    /// An array of URLs pointing to additional celebrity information.
    urls: ?[]const []const u8,

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
