/// Contains details about the configuration of the Amazon Kendra index used for
/// the `AMAZON.QnAIntent`.
pub const QnAKendraConfiguration = struct {
    /// Specifies whether to return an exact response from the Amazon Kendra index
    /// or to let the Amazon Bedrock model you select generate a response based on
    /// the results. To use this feature, you must first add FAQ questions to your
    /// index by following the steps at [Adding frequently asked questions (FAQs) to
    /// an
    /// index](https://docs.aws.amazon.com/kendra/latest/dg/in-creating-faq.html).
    exact_response: bool = false,

    /// The ARN of the Amazon Kendra index to use.
    kendra_index: []const u8,

    /// Contains the Amazon Kendra filter string to use if enabled. For more
    /// information on the Amazon Kendra search filter JSON format, see [Using
    /// document attributes to filter search
    /// results](https://docs.aws.amazon.com/kendra/latest/dg/filtering.html#search-filtering).
    query_filter_string: ?[]const u8,

    /// Specifies whether to enable an Amazon Kendra filter string or not.
    query_filter_string_enabled: bool = false,

    pub const json_field_names = .{
        .exact_response = "exactResponse",
        .kendra_index = "kendraIndex",
        .query_filter_string = "queryFilterString",
        .query_filter_string_enabled = "queryFilterStringEnabled",
    };
};
