const AnalyticsIntentStageFilterName = @import("analytics_intent_stage_filter_name.zig").AnalyticsIntentStageFilterName;
const AnalyticsFilterOperator = @import("analytics_filter_operator.zig").AnalyticsFilterOperator;

/// Contains fields describing a condition by which to filter the intent stages.
/// The expression may be understood as `name`
/// `operator`
/// `values`. For example:
///
/// * `IntentName CO Book` – The intent name contains the string "Book."
///
/// * `BotVersion EQ 2` – The bot version is equal to two.
///
/// The operators that each filter supports are listed below:
///
/// * `BotAlias` – `EQ`.
///
/// * `BotVersion` – `EQ`.
///
/// * `LocaleId` – `EQ`.
///
/// * `Modality` – `EQ`.
///
/// * `Channel` – `EQ`.
///
/// * `SessionId` – `EQ`.
///
/// * `OriginatingRequestId` – `EQ`.
///
/// * `IntentName` – `EQ`, `CO`.
///
/// * `IntentStageName` – `EQ`, `CO`.
pub const AnalyticsIntentStageFilter = struct {
    /// The category by which to filter the intent stages. The descriptions for each
    /// option are as follows:
    ///
    /// * `BotAlias` – The name of the bot alias.
    ///
    /// * `BotVersion` – The version of the bot.
    ///
    /// * `LocaleId` – The locale of the bot.
    ///
    /// * `Modality` – The modality of the session with the bot (audio, DTMF, or
    ///   text).
    ///
    /// * `Channel` – The channel that the bot is integrated with.
    ///
    /// * `SessionId` – The identifier of the session with the bot.
    ///
    /// * `OriginatingRequestId` – The identifier of the first request in a session.
    ///
    /// * `IntentName` – The name of the intent.
    ///
    /// * `IntentStageName` – The stage in the intent.
    name: AnalyticsIntentStageFilterName,

    /// The operation by which to filter the category. The following operations are
    /// possible:
    ///
    /// * `CO` – Contains
    ///
    /// * `EQ` – Equals
    ///
    /// * `GT` – Greater than
    ///
    /// * `LT` – Less than
    ///
    /// The operators that each filter supports are listed below:
    ///
    /// * `BotAlias` – `EQ`.
    ///
    /// * `BotVersion` – `EQ`.
    ///
    /// * `LocaleId` – `EQ`.
    ///
    /// * `Modality` – `EQ`.
    ///
    /// * `Channel` – `EQ`.
    ///
    /// * `SessionId` – `EQ`.
    ///
    /// * `OriginatingRequestId` – `EQ`.
    ///
    /// * `IntentName` – `EQ`, `CO`.
    ///
    /// * `IntentStageName` – `EQ`, `CO`.
    operator: AnalyticsFilterOperator,

    /// An array containing the values of the category by which to apply the
    /// operator to filter the results. You can provide multiple values if the
    /// operator is `EQ` or `CO`. If you provide multiple values, you filter for
    /// results that equal/contain any of the values. For example, if the `name`,
    /// `operator`, and `values` fields are `Modality`, `EQ`, and `[Speech, Text]`,
    /// the operation filters for results where the modality was either `Speech` or
    /// `Text`.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .operator = "operator",
        .values = "values",
    };
};
