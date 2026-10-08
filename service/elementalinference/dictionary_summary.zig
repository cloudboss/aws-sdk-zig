const DictionaryLanguage = @import("dictionary_language.zig").DictionaryLanguage;
const DictionaryStatus = @import("dictionary_status.zig").DictionaryStatus;

/// Contains summary information about a dictionary. Used in the
/// ListDictionaries response.
pub const DictionarySummary = struct {
    /// The ARN of the dictionary.
    arn: []const u8,

    /// The ID of the dictionary.
    id: []const u8,

    /// The language of the dictionary.
    language: DictionaryLanguage,

    /// The name of the dictionary.
    name: []const u8,

    /// The status of the dictionary.
    status: DictionaryStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .language = "language",
        .name = "name",
        .status = "status",
    };
};
