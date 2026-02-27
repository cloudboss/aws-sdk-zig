const ProtectiveEquipmentBodyPart = @import("protective_equipment_body_part.zig").ProtectiveEquipmentBodyPart;
const BoundingBox = @import("bounding_box.zig").BoundingBox;

/// A person detected by a call to DetectProtectiveEquipment. The API returns
/// all persons detected in the input
/// image in an array of `ProtectiveEquipmentPerson` objects.
pub const ProtectiveEquipmentPerson = struct {
    /// An array of body parts detected on a person's body (including body parts
    /// without PPE).
    body_parts: ?[]const ProtectiveEquipmentBodyPart,

    /// A bounding box around the detected person.
    bounding_box: ?BoundingBox,

    /// The confidence that Amazon Rekognition has that the bounding box contains a
    /// person.
    confidence: ?f32,

    /// The identifier for the detected person. The identifier is only unique for a
    /// single call to
    /// `DetectProtectiveEquipment`.
    id: ?i32,

    pub const json_field_names = .{
        .body_parts = "BodyParts",
        .bounding_box = "BoundingBox",
        .confidence = "Confidence",
        .id = "Id",
    };
};
