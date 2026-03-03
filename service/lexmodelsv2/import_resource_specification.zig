const BotImportSpecification = @import("bot_import_specification.zig").BotImportSpecification;
const BotLocaleImportSpecification = @import("bot_locale_import_specification.zig").BotLocaleImportSpecification;
const CustomVocabularyImportSpecification = @import("custom_vocabulary_import_specification.zig").CustomVocabularyImportSpecification;
const TestSetImportResourceSpecification = @import("test_set_import_resource_specification.zig").TestSetImportResourceSpecification;

/// Provides information about the bot or bot locale that you want to
/// import. You can specify the `botImportSpecification` or the
/// `botLocaleImportSpecification`, but not both.
pub const ImportResourceSpecification = struct {
    /// Parameters for importing a bot.
    bot_import_specification: ?BotImportSpecification = null,

    /// Parameters for importing a bot locale.
    bot_locale_import_specification: ?BotLocaleImportSpecification = null,

    custom_vocabulary_import_specification: ?CustomVocabularyImportSpecification = null,

    /// Specifications for the test set that is imported.
    test_set_import_resource_specification: ?TestSetImportResourceSpecification = null,

    pub const json_field_names = .{
        .bot_import_specification = "botImportSpecification",
        .bot_locale_import_specification = "botLocaleImportSpecification",
        .custom_vocabulary_import_specification = "customVocabularyImportSpecification",
        .test_set_import_resource_specification = "testSetImportResourceSpecification",
    };
};
