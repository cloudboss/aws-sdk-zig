const AttributeSuggestionsMode = @import("attribute_suggestions_mode.zig").AttributeSuggestionsMode;
const SuggestableConfig = @import("suggestable_config.zig").SuggestableConfig;

/// Gets information on the configuration of document fields/attributes that you
/// want to base
/// query suggestions on. To change your configuration, use
/// [AttributeSuggestionsUpdateConfig](https://docs.aws.amazon.com/kendra/latest/dg/API_AttributeSuggestionsUpdateConfig.html) and then call [UpdateQuerySuggestionsConfig](https://docs.aws.amazon.com/kendra/latest/dg/API_UpdateQuerySuggestionsConfig.html).
pub const AttributeSuggestionsDescribeConfig = struct {
    /// The mode is set to either `ACTIVE` or `INACTIVE`. If the `Mode`
    /// for query history is set to `ENABLED` when calling
    /// [UpdateQuerySuggestionsConfig](https://docs.aws.amazon.com/kendra/latest/dg/API_UpdateQuerySuggestionsConfig.html)
    /// and `AttributeSuggestionsMode` to use fields/attributes is set to `ACTIVE`,
    /// and you haven't set your `SuggestionTypes` preference to
    /// `DOCUMENT_ATTRIBUTES`,
    /// then Amazon Kendra uses the query history.
    attribute_suggestions_mode: ?AttributeSuggestionsMode = null,

    /// The list of fields/attributes that you want to set as suggestible for query
    /// suggestions.
    suggestable_config_list: ?[]const SuggestableConfig = null,

    pub const json_field_names = .{
        .attribute_suggestions_mode = "AttributeSuggestionsMode",
        .suggestable_config_list = "SuggestableConfigList",
    };
};
