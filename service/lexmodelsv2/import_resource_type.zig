pub const ImportResourceType = enum {
    bot,
    bot_locale,
    custom_vocabulary,
    test_set,

    pub const json_field_names = .{
        .bot = "Bot",
        .bot_locale = "BotLocale",
        .custom_vocabulary = "CustomVocabulary",
        .test_set = "TestSet",
    };
};
