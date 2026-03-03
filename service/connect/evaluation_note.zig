/// Information about notes for a contact evaluation.
pub const EvaluationNote = struct {
    /// The note for an item (section or question) in a contact evaluation.
    ///
    /// Even though a note in an evaluation can have up to 3072 chars, there is also
    /// a limit on the total number of
    /// chars for all the notes in the evaluation combined. Assuming there are N
    /// questions in the evaluation being
    /// submitted, then the max char limit for all notes combined is N x 1024.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .value = "Value",
    };
};
