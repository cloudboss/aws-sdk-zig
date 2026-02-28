const BoundingBox = @import("bounding_box.zig").BoundingBox;
const CoversBodyPart = @import("covers_body_part.zig").CoversBodyPart;
const ProtectiveEquipmentType = @import("protective_equipment_type.zig").ProtectiveEquipmentType;

/// Information about an item of Personal Protective Equipment (PPE) detected by
/// DetectProtectiveEquipment. For more
/// information, see DetectProtectiveEquipment.
pub const EquipmentDetection = struct {
    /// A bounding box surrounding the item of detected PPE.
    bounding_box: ?BoundingBox,

    /// The confidence that Amazon Rekognition has that the bounding box
    /// (`BoundingBox`) contains an item of PPE.
    confidence: ?f32,

    /// Information about the body part covered by the detected PPE.
    covers_body_part: ?CoversBodyPart,

    /// The type of detected PPE.
    @"type": ?ProtectiveEquipmentType,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .confidence = "Confidence",
        .covers_body_part = "CoversBodyPart",
        .@"type" = "Type",
    };
};
