const Entity = @import("entity.zig").Entity;
const Item = @import("item.zig").Item;

/// A list of possible alternative transcriptions for the input audio. Each
/// alternative may contain
/// one or more of `Items`, `Entities`, or `Transcript`.
pub const Alternative = struct {
    /// Contains entities identified as personally identifiable information (PII) in
    /// your transcription
    /// output.
    entities: ?[]const Entity = null,

    /// Contains words, phrases, or punctuation marks in your transcription output.
    items: ?[]const Item = null,

    /// Contains transcribed text.
    transcript: ?[]const u8 = null,

    pub const json_field_names = .{
        .entities = "Entities",
        .items = "Items",
        .transcript = "Transcript",
    };
};
