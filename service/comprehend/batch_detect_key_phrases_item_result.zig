const KeyPhrase = @import("key_phrase.zig").KeyPhrase;

/// The result of calling the operation. The
/// operation returns one object for each document that is successfully
/// processed by the
/// operation.
pub const BatchDetectKeyPhrasesItemResult = struct {
    /// The zero-based index of the document in the input list.
    index: ?i32 = null,

    /// One or more KeyPhrase objects, one for each key phrase detected in
    /// the document.
    key_phrases: ?[]const KeyPhrase = null,

    pub const json_field_names = .{
        .index = "Index",
        .key_phrases = "KeyPhrases",
    };
};
