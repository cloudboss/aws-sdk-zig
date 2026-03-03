const DominantLanguage = @import("dominant_language.zig").DominantLanguage;

/// The result of calling the operation.
/// The operation returns one object for each document that is successfully
/// processed by the
/// operation.
pub const BatchDetectDominantLanguageItemResult = struct {
    /// The zero-based index of the document in the input list.
    index: ?i32 = null,

    /// One or more DominantLanguage objects describing the dominant
    /// languages in the document.
    languages: ?[]const DominantLanguage = null,

    pub const json_field_names = .{
        .index = "Index",
        .languages = "Languages",
    };
};
