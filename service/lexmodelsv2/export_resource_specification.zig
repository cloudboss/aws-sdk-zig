const BotExportSpecification = @import("bot_export_specification.zig").BotExportSpecification;
const BotLocaleExportSpecification = @import("bot_locale_export_specification.zig").BotLocaleExportSpecification;
const CustomVocabularyExportSpecification = @import("custom_vocabulary_export_specification.zig").CustomVocabularyExportSpecification;
const TestSetExportSpecification = @import("test_set_export_specification.zig").TestSetExportSpecification;

/// Provides information about the bot or bot locale that you want to
/// export. You can specify the `botExportSpecification` or the
/// `botLocaleExportSpecification`, but not both.
pub const ExportResourceSpecification = struct {
    /// Parameters for exporting a bot.
    bot_export_specification: ?BotExportSpecification,

    /// Parameters for exporting a bot locale.
    bot_locale_export_specification: ?BotLocaleExportSpecification,

    /// The parameters required to export a custom vocabulary.
    custom_vocabulary_export_specification: ?CustomVocabularyExportSpecification,

    /// Specifications for the test set that is exported as a resource.
    test_set_export_specification: ?TestSetExportSpecification,

    pub const json_field_names = .{
        .bot_export_specification = "botExportSpecification",
        .bot_locale_export_specification = "botLocaleExportSpecification",
        .custom_vocabulary_export_specification = "customVocabularyExportSpecification",
        .test_set_export_specification = "testSetExportSpecification",
    };
};
