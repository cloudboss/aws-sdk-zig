const LanguageConfiguration = @import("language_configuration.zig").LanguageConfiguration;
const RedactionConfiguration = @import("redaction_configuration.zig").RedactionConfiguration;
const RulesConfiguration = @import("rules_configuration.zig").RulesConfiguration;
const SentimentConfiguration = @import("sentiment_configuration.zig").SentimentConfiguration;
const SummaryConfiguration = @import("summary_configuration.zig").SummaryConfiguration;

/// The configuration for conversational analytics.
pub const AnalyticsConfiguration = struct {
    /// The language configuration for conversational analytics.
    language_configuration: LanguageConfiguration,

    /// The redaction configuration for conversational analytics.
    redaction_configuration: RedactionConfiguration,

    /// The rules configuration for conversational analytics.
    rules_configuration: RulesConfiguration,

    /// The sentiment configuration for conversational analytics.
    sentiment_configuration: SentimentConfiguration,

    /// The summary configuration for conversational analytics.
    summary_configuration: SummaryConfiguration,

    pub const json_field_names = .{
        .language_configuration = "LanguageConfiguration",
        .redaction_configuration = "RedactionConfiguration",
        .rules_configuration = "RulesConfiguration",
        .sentiment_configuration = "SentimentConfiguration",
        .summary_configuration = "SummaryConfiguration",
    };
};
