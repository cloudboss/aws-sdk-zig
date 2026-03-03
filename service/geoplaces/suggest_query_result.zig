const QueryType = @import("query_type.zig").QueryType;

/// The suggested query results.
pub const SuggestQueryResult = struct {
    /// QueryId can be used to complete a follow up query through the SearchText
    /// API. The QueryId retains context from the original Suggest request such as
    /// filters, political view and language. See the SearchText API documentation
    /// for more details [SearchText API
    /// docs](https://docs.aws.amazon.com/location/latest/APIReference/API_geoplaces_SearchText.html).
    ///
    /// The fields `QueryText`, and `QueryID` are mutually exclusive.
    query_id: ?[]const u8 = null,

    /// The query type. Category queries will search for places which have an entry
    /// matching the given category, for example "doctor office". BusinessChain
    /// queries will search for instances of a given business.
    query_type: ?QueryType = null,

    pub const json_field_names = .{
        .query_id = "QueryId",
        .query_type = "QueryType",
    };
};
