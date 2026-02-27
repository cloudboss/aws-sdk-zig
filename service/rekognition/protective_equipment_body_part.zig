const EquipmentDetection = @import("equipment_detection.zig").EquipmentDetection;
const BodyPart = @import("body_part.zig").BodyPart;

/// Information about a body part detected by DetectProtectiveEquipment that
/// contains PPE.
/// An array of `ProtectiveEquipmentBodyPart` objects is returned for each
/// person detected by
/// `DetectProtectiveEquipment`.
pub const ProtectiveEquipmentBodyPart = struct {
    /// The confidence that Amazon Rekognition has in the detection accuracy of the
    /// detected body part.
    confidence: ?f32,

    /// An array of Personal Protective Equipment items detected around a body part.
    equipment_detections: ?[]const EquipmentDetection,

    /// The detected body part.
    name: ?BodyPart,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .equipment_detections = "EquipmentDetections",
        .name = "Name",
    };
};
