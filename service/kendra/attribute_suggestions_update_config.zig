const AttributeSuggestionsMode = @import("attribute_suggestions_mode.zig").AttributeSuggestionsMode;
const SuggestableConfig = @import("suggestable_config.zig").SuggestableConfig;

/// Updates the configuration information for the document fields/attributes
/// that you want
/// to base query suggestions on.
///
/// To deactivate using documents fields for query suggestions, set the mode to
/// `INACTIVE`. You must also set `SuggestionTypes` as either
/// `QUERY` or `DOCUMENT_ATTRIBUTES` and then call
/// [GetQuerySuggestions](https://docs.aws.amazon.com/kendra/latest/dg/API_GetQuerySuggestions.html). If you set to `QUERY`, then
/// Amazon Kendra uses the query history to base suggestions on. If you set to
/// `DOCUMENT_ATTRIBUTES`, then Amazon Kendra uses the contents of document
/// fields to base suggestions on.
pub const AttributeSuggestionsUpdateConfig = struct {
    /// You can set the mode to `ACTIVE` or `INACTIVE`. You must also set
    /// `SuggestionTypes` as either `QUERY` or `DOCUMENT_ATTRIBUTES`
    /// and then call
    /// [GetQuerySuggestions](https://docs.aws.amazon.com/kendra/latest/dg/API_GetQuerySuggestions.html). If `Mode` to use query history is set to
    /// `ENABLED` when calling
    /// [UpdateQuerySuggestionsConfig](https://docs.aws.amazon.com/kendra/latest/dg/API_UpdateQuerySuggestionsConfig.html) and `AttributeSuggestionsMode` to use
    /// fields/attributes is set to `ACTIVE`, and you haven't set your
    /// `SuggestionTypes` preference to `DOCUMENT_ATTRIBUTES`, then
    /// Amazon Kendra uses the query history.
    attribute_suggestions_mode: ?AttributeSuggestionsMode,

    /// The list of fields/attributes that you want to set as suggestible for query
    /// suggestions.
    suggestable_config_list: ?[]const SuggestableConfig,

    pub const json_field_names = .{
        .attribute_suggestions_mode = "AttributeSuggestionsMode",
        .suggestable_config_list = "SuggestableConfigList",
    };
};
