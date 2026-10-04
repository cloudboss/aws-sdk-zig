/// Revenue statistics for a single AI bot source, including the bot name,
/// revenue amount, request count, and verification status.
pub const SourceStatistics = struct {
    /// The total revenue amount from this source in the specified currency.
    amount: []const u8,

    /// The value for the group-by dimension, when grouping is applied.
    group_by_value: ?[]const u8 = null,

    /// The declared intent of the AI bot (for example, summarize, index, or train).
    intent: ?[]const u8 = null,

    /// The organization associated with the AI bot.
    organization: ?[]const u8 = null,

    /// The percentage of total revenue from this source.
    percentage: f64 = 0,

    /// The number of monetized requests from this source.
    request_count: i64 = 0,

    /// The category of this AI bot source.
    source_category: ?[]const u8 = null,

    /// The name of the AI bot.
    source_name: []const u8,

    /// Indicates whether the AI bot's identity was verified — for example, through
    /// a cryptographically signed request (Web Bot Auth) or another published
    /// verification method. This value is meaningful only when GroupBy is NAME,
    /// where each result represents a single, identifiable bot. For all other
    /// GroupBy values (CATEGORY, INTENT, ORGANIZATION, or WEBACL), a result
    /// aggregates multiple bots that may have different verification states, so
    /// Verified is always returned as false and should be ignored. Type and
    /// required-ness are unchanged (Boolean, optional).
    verified: bool = false,

    pub const json_field_names = .{
        .amount = "Amount",
        .group_by_value = "GroupByValue",
        .intent = "Intent",
        .organization = "Organization",
        .percentage = "Percentage",
        .request_count = "RequestCount",
        .source_category = "SourceCategory",
        .source_name = "SourceName",
        .verified = "Verified",
    };
};
