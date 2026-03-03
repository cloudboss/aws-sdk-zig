/// Provides configuration information for the AMAZON.KendraSearchIntent
/// intent. When you use this intent, Amazon Lex searches the specified Amazon
/// Kendra index and returns documents from the index that match the user's
/// utterance. For more information, see [
/// AMAZON.KendraSearchIntent](http://docs.aws.amazon.com/lex/latest/dg/built-in-intent-kendra-search.html).
pub const KendraConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Kendra index that you
    /// want the AMAZON.KendraSearchIntent intent to search. The index must be in
    /// the same account and Region as the Amazon Lex bot. If the Amazon Kendra
    /// index
    /// does not exist, you get an exception when you call the
    /// `PutIntent` operation.
    kendra_index: []const u8,

    /// A query filter that Amazon Lex sends to Amazon Kendra to filter the
    /// response from the query. The filter is in the format defined by Amazon
    /// Kendra. For more information, see [Filtering
    /// queries](http://docs.aws.amazon.com/kendra/latest/dg/filtering.html).
    ///
    /// You can override this filter string with a new filter string at
    /// runtime.
    query_filter_string: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an IAM role that has permission to
    /// search the Amazon Kendra index. The role must be in the same account and
    /// Region as the Amazon Lex bot. If the role does not exist, you get an
    /// exception
    /// when you call the `PutIntent` operation.
    role: []const u8,

    pub const json_field_names = .{
        .kendra_index = "kendraIndex",
        .query_filter_string = "queryFilterString",
        .role = "role",
    };
};
