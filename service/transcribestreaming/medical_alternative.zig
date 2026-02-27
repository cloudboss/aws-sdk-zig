const MedicalEntity = @import("medical_entity.zig").MedicalEntity;
const MedicalItem = @import("medical_item.zig").MedicalItem;

/// A list of possible alternative transcriptions for the input audio. Each
/// alternative may
/// contain one or more of `Items`, `Entities`, or
/// `Transcript`.
pub const MedicalAlternative = struct {
    /// Contains entities identified as personal health information (PHI) in your
    /// transcription
    /// output.
    entities: ?[]const MedicalEntity,

    /// Contains words, phrases, or punctuation marks in your transcription output.
    items: ?[]const MedicalItem,

    /// Contains transcribed text.
    transcript: ?[]const u8,

    pub const json_field_names = .{
        .entities = "Entities",
        .items = "Items",
        .transcript = "Transcript",
    };
};
