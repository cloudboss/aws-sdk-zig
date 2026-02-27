/// The updated note.
pub const NoteUpdate = struct {
    /// The updated note text.
    text: []const u8,

    /// The principal that updated the note.
    updated_by: []const u8,

    pub const json_field_names = .{
        .text = "Text",
        .updated_by = "UpdatedBy",
    };
};
