const Entity = @import("entity.zig").Entity;
const Item = @import("item.zig").Item;

/// A list of possible alternative transcriptions for the input audio. Each
/// alternative may contain
/// one or more of `Items`, `Entities`, or `Transcript`.
pub const Alternative = struct {
    /// Contains entities identified as personally identifiable information (PII) in
    /// your transcription
    /// output.
    entities: ?[]const Entity,

    /// Contains words, phrases, or punctuation marks in your transcription output.
    items: ?[]const Item,

    /// Contains transcribed text.
    transcript: ?[]const u8,

    pub const json_field_names = .{
        .entities = "Entities",
        .items = "Items",
        .transcript = "Transcript",
    };
};
