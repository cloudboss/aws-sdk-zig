const ListResponseScope = @import("list_response_scope.zig").ListResponseScope;

pub const ListFleetsRequest = struct {
    /// When you set the `listResponseScope` parameter to `METADATA_ONLY`, the list
    /// response includes: fleet ID, Amazon Resource Name (ARN), creation time, and
    /// last modification time.
    list_response_scope: ?ListResponseScope,

    /// The maximum number of items to return, between 1 and 100, inclusive.
    max_results: ?i32,

    /// A pagination token for the next set of results.
    ///
    /// If the results of a search are large, only a portion of the results are
    /// returned, and a `nextToken` pagination token is returned in the response. To
    /// retrieve the next set of results, reissue the search request and include the
    /// returned token. When all results have been returned, the response does not
    /// contain a pagination token value.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .list_response_scope = "listResponseScope",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};
