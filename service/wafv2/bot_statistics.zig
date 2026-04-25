/// Statistics about a specific bot's traffic to a path, including the bot name,
/// request count, and percentage of traffic.
pub const BotStatistics = struct {
    /// The name of the bot. For example, `gptbot` or `googlebot`.
    bot_name: []const u8,

    /// The percentage of total requests to the associated path that came from this
    /// bot.
    percentage: f64 = 0,

    /// The number of requests from this bot to the associated path within the
    /// specified time window.
    request_count: i64 = 0,

    pub const json_field_names = .{
        .bot_name = "BotName",
        .percentage = "Percentage",
        .request_count = "RequestCount",
    };
};
