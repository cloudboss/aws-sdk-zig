/// Provides configuration information for the `AMAZON.KendraSearchIntent`
/// intent. When you use this intent, Amazon Lex searches the specified Amazon
/// Kendra
/// index and returns documents from the index that match the user's
/// utterance.
pub const KendraConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Kendra index that you want the
    /// `AMAZON.KendraSearchIntent` intent to search. The index must be in the
    /// same account and Region as the Amazon Lex bot.
    kendra_index: []const u8,

    /// A query filter that Amazon Lex sends to Amazon Kendra to filter the response
    /// from
    /// a query. The filter is in the format defined by Amazon Kendra. For more
    /// information, see [Filtering
    /// queries](https://docs.aws.amazon.com/kendra/latest/dg/filtering.html).
    query_filter_string: ?[]const u8 = null,

    /// Determines whether the `AMAZON.KendraSearchIntent` intent uses a
    /// custom query string to query the Amazon Kendra index.
    query_filter_string_enabled: bool = false,

    pub const json_field_names = .{
        .kendra_index = "kendraIndex",
        .query_filter_string = "queryFilterString",
        .query_filter_string_enabled = "queryFilterStringEnabled",
    };
};
