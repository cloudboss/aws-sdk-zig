pub const ListTagsForResourceRequest = struct {
    /// The maximum number of objects that you want WAF to return for this request.
    /// If more
    /// objects are available, in the response, WAF provides a
    /// `NextMarker` value that you can use in a subsequent call to get the next
    /// batch of objects.
    limit: ?i32 = null,

    /// When you request a list of objects with a `Limit` setting, if the number of
    /// objects that are still available
    /// for retrieval exceeds the limit, WAF returns a `NextMarker`
    /// value in the response. To retrieve the next batch of objects, provide the
    /// marker from the prior call in your next request.
    next_marker: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .limit = "Limit",
        .next_marker = "NextMarker",
        .resource_arn = "ResourceARN",
    };
};
