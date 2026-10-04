pub const ListChannelsRequest = struct {
    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region.
    channel_group_name: []const u8,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// The pagination token from the GET list request. Use the token to fetch the
    /// next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_group_name = "ChannelGroupName",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
