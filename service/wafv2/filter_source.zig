/// Information about the bot filter that was applied to the request. This
/// structure is populated in the response when you filter by bot category,
/// organization, or name.
pub const FilterSource = struct {
    /// The bot category that was used to filter the results. For example, `ai` or
    /// `search_engine`.
    bot_category: ?[]const u8 = null,

    /// The bot name that was used to filter the results. For example, `gptbot` or
    /// `googlebot`.
    bot_name: ?[]const u8 = null,

    /// The bot organization that was used to filter the results. For example,
    /// `OpenAI` or `Google`.
    bot_organization: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_category = "BotCategory",
        .bot_name = "BotName",
        .bot_organization = "BotOrganization",
    };
};
